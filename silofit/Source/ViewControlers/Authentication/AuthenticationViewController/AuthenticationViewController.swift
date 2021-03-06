//
//  AuthenticationViewController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-23.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import Firebase

class AuthenticationViewController: BaseViewController {

    let viewModel: AuthenticationViewModel
    
    let emailTextField: StyledTextField = {

        let textField = StyledTextField(placeholder: "E-mail")
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.returnKeyType = .next
        textField.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: .editingChanged)
        return textField
    }()

    let passwordTextField: StyledTextField = {

        let textField = StyledTextField(placeholder: "Password")
        textField.textContentType = .password
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: .editingChanged)
        return textField
    }()

    let actionButton: StyledButton

    init(viewModel: AuthenticationViewModel) {

        self.viewModel = viewModel
        
        self.actionButton = StyledButton(style: .dark,
                                         title: self.viewModel.actionButtonTitle)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {

        self.view.backgroundColor = StyleColor.background

        self.title = self.viewModel.title

        // bar button
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelButtonTouchUpInside))
        self.navigationItem.leftBarButtonItem = cancelButton

        // text fields
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self

        // stack View, including its contents
        self.setupStackView()

        // action button
        self.actionButton.isEnabled = false
        self.actionButton.addTarget(self,
                                    action: #selector(actionButtonTouchUpInside),
                                    for: .touchUpInside)

        // text field
        if #available(iOS 12.0, *), self.viewModel.mode == .signup {
            self.passwordTextField.textContentType = .newPassword
        }
    }

    private func setupStackView() {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.large

        stackView.addArrangedSubview(self.emailTextField)
        stackView.addArrangedSubview(self.passwordTextField)
        stackView.addArrangedSubview(self.actionButton)

        self.view.addSubview(stackView)

        // Here, for simplicity, it assumes that stack view won't be taller than
        // the viewController.view. So it just top aligned to topAnchor.
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                           constant: Spacing.large).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                            constant: -Spacing.large).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                       constant: Spacing.large).isActive = true
    }

    // MARK: - Selector Methods
    @objc private func cancelButtonTouchUpInside() {
        
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func actionButtonTouchUpInside() {

        guard
            let email = self.emailTextField.text,
            let password = self.passwordTextField.text
            else {
                return
        }

        self.view.endEditing(true)
        self.actionButton.isEnabled = false

        // Firebase is giving meaningful localizedDescription in their errors.
        // So here, no extra error handling is done.
        // The localizedDescription is directly shown in an AlertController.
        let authResultHandler: (Result<Void, Error>) -> Void = { [weak self] (result) in
            switch result {
            case .success():
                // If auth succeed, AuthenticationManager will notify AuthOptionsViewController
                // via AuthStateUpdatingDelegate to dismiss AuthenticationViewController/
                break
            case .failure(let error):
                self?.actionButton.isEnabled = true
                self?.presentAlert(forError: error,
                                   withTitle: "Auth failed",
                                   action: nil)
            }
        }

        switch self.viewModel.mode {
        case .signup:
            self.viewModel.createAccount(
                withEmail: email,
                password: password
            ) { (result) in
                authResultHandler(result)
            }
        case .login:
            self.viewModel.login(
                withEmail: email,
                password: password
            ) { (result) in
                authResultHandler(result)
            }
        }
    }

    @objc private func textFieldDidChange(sender: StyledTextField) {

        guard
            let email = self.emailTextField.text,
            let password = self.passwordTextField.text
            else {
                return
        }

        let shouldButtonEnabled = email.isValidEmailAddress && password.count > 0
        self.actionButton.isEnabled = shouldButtonEnabled
    }
}

extension AuthenticationViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        guard let textField = textField as? StyledTextField else {
            return true
        }

        switch textField {
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()

        case self.passwordTextField:
            textField.resignFirstResponder()

        default:
            break
        }
        return false
    }
}
