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

    enum Mode {
        case signup
        case login

        var actionButtonTitle: String {
            switch self {
            case .signup:
                return "Create Account"
            case .login:
                return "Login"
            }
        }

        var title: String {
            switch self {
            case .signup:
                return "Almost there!"
            case .login:
                return "Welcome Back!"
            }
        }
    }

    let mode: Mode

    let emailTextField: StyledTextField = {

        let textField = StyledTextField(placeholder: "E-mail")
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .unlessEditing
        textField.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: .editingChanged)
        return textField
    }()

    let passwordTextField: StyledTextField = {

        let textField = StyledTextField(placeholder: "Password")
        textField.textContentType = .password
        textField.clearButtonMode = .unlessEditing
        textField.isSecureTextEntry = true
        textField.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: .editingChanged)
        return textField
    }()

    let actionButton: StyledButton

    init(mode: Mode) {

        self.mode = mode
        self.actionButton = StyledButton(style: .dark,
                                         title: mode.actionButtonTitle)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupUI() {

        self.view.backgroundColor = StyleColor.light

        self.title = self.mode.title

        // bar button
        let cancelButton = UIBarButtonItem(title: "cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelButtonTouchUpInside))
        self.navigationItem.leftBarButtonItem = cancelButton

        // stack View
        self.setupStackView()

        // action button
        self.actionButton.isEnabled = false
        self.actionButton.addTarget(self,
                                    action: #selector(actionButtonTouchUpInside),
                                    for: .touchUpInside)

        // text field
        if #available(iOS 12.0, *), mode == .signup {
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

        if self.mode == .signup {
            let passwordRuleLabel = UILabel()
            passwordRuleLabel.translatesAutoresizingMaskIntoConstraints = false
            passwordRuleLabel.text = "Password needs to have at least \(AuthenticationManager.passwordMinimumLength) characters"
            stackView.addArrangedSubview(passwordRuleLabel)
        }
        stackView.addArrangedSubview(self.actionButton)

        self.view.addSubview(stackView)

        // Here, for simplicity, it assumes that stack view won't be taller than
        // the viewController.view. So it just centerYAnchor aligned.
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                           constant: Spacing.large).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                            constant: -Spacing.large).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    // MARK: - Selector Methods
    @objc private func cancelButtonTouchUpInside() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func actionButtonTouchUpInside() {

        
    }

    @objc private func textFieldDidChange(sender: StyledTextField) {

        guard
            let email = self.emailTextField.text,
            let password = self.passwordTextField.text
            else {
                return
        }

        let shouldButtonEnabled = email.isValidEmailAddress && password.isValidAsPassword
        self.actionButton.isEnabled = shouldButtonEnabled
    }
}
