//
//  AuthOptionsViewController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class AuthOptionsViewController: BaseViewController {

    private lazy var signupButton: UIButton = {
        let button = StyledButton(style: .dark, title: "Sign In")
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = StyledButton(style: .light, title: "Join Now")
        return button
    }()

    override func setupUI() {

        self.view.backgroundColor = StyleColor.light

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.large

        stackView.addArrangedSubview(self.signupButton)
        stackView.addArrangedSubview(self.loginButton)

        self.view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                           constant: Spacing.large).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                            constant: -Spacing.large).isActive = true

        let verticalSpacing = self.keyWindowSafeAreaInsets.top == 0 ? Spacing.regular : 0
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                          constant: verticalSpacing).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.topAnchor,
                                       constant: verticalSpacing).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

