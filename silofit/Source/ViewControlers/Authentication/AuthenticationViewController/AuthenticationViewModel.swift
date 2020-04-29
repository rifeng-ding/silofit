//
//  AuthenticationViewModel.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-29.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

class AuthenticationViewModel {
    
    enum Mode {
        case signup
        case login
    }

    let mode: Mode
    let authService: AuthService
    
    init(mode: Mode, authService: AuthService) {
        
        self.mode = mode
        self.authService = authService
    }
    
    var title: String {
        switch self.mode {
        case .signup:
            return "Welcome Aboard!"
        case .login:
            return "Welcome Back!"
        }
    }
    
    var actionButtonTitle: String {
        switch self.mode {
        case .signup:
            return "Create Account"
        case .login:
            return "Login"
        }
    }

    func createAccount(withEmail email:String,
                       password: String,
                       completion: @escaping ((Result<Void, Error>) -> Void)) {
        self.authService.createAccount(
            withEmail: email,
            password: password
        ) { (result) in
            completion(result)
        }
    }
    
    func login(withEmail email:String,
               password: String,
               completion: @escaping ((Result<Void, Error>) -> Void)) {
        self.authService.login(
            withEmail: email,
            password: password
        ) { (result) in
            completion(result)
        }
    }
}
