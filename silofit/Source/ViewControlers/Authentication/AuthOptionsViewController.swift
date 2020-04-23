//
//  AuthOptionsViewController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class AuthOptionsViewController: BaseViewController {

    private let loginButton: StyledButton = {
        
        let button = StyledButton(style: .dark, title: "Sign In")
        button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        return button
    }()
    
    private let signupButton: StyledButton = {

        let button = StyledButton(style: .light, title: "Join Now")
        button.addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        return button
    }()

    override func setupUI() {

        self.view.backgroundColor = StyleColor.light

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.large

        self.signupButton.isEnabled = false
        stackView.addArrangedSubview(self.signupButton)
        self.loginButton.isEnabled = false
        stackView.addArrangedSubview(self.loginButton)

        self.view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                           constant: Spacing.large).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                            constant: -Spacing.large).isActive = true

        let verticalSpacing = self.keyWindowSafeAreaInsets.bottom == 0 ? Spacing.large : 0
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                          constant: -verticalSpacing).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor,
                                       constant: verticalSpacing).isActive = true
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        AuthenticationManager.shared.stateUpdatingDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        self.presentMapViewControllerIfNeeded()
    }

    private func presentMapViewControllerIfNeeded() {

        guard AuthenticationManager.shared.isLogin else {
            self.loginButton.isEnabled = true
            self.signupButton.isEnabled = true
            return
        }

        // this is to prevent user tap the button again during the transition
        self.loginButton.isEnabled = false
        self.signupButton.isEnabled = false

        let navigationViewController = StyledNavigationController(rootViewController: MapViewController())
        navigationViewController.modalTransitionStyle = .flipHorizontal
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController,
                     animated: true,
                     completion: nil)
    }

    // MARK: - Button Actions
    @objc private func buttonTouchUp(sender: StyledButton) {

        var mode: AuthenticationViewController.Mode?
        switch sender {
        case self.loginButton:
            mode = .login
        case self.signupButton:
            mode = .signup
        default:
            break
        }
        guard let authMode = mode else {
            return
        }
        let authViewController = AuthenticationViewController(mode: authMode)
        self.present(StyledNavigationController(rootViewController: authViewController),
                     animated: true,
                     completion: nil)
    }
}

extension AuthOptionsViewController: AuthStateUpdatingDelegate {

    func authStateDidChange() {

        if self.presentedViewController != nil {
            self.dismiss(animated: true) {
                self.presentMapViewControllerIfNeeded()
            }
        } else {
            self.presentMapViewControllerIfNeeded()
        }
    }
}
