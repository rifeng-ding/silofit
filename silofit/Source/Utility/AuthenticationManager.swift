//
//  AuthenticationManager.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

final class AuthenticationManager {

    static let passwordMinimumLength: Int = 8

    static let shared = AuthenticationManager()

    // TODO: mock for now
    var isLogin: Bool {
        
        return false
    }

    func logout(_ completion: (Error?) -> Void) {

        // mock
        completion(nil)
    }

    func createAccount(withEmail email: String,
                       password: String,
                       completion: ((Error) -> Void)) {

    }

    func login(withEmail email: String,
               password: String,
               completion: ((Error) -> Void)) {

    }
}

extension String {

    var isValidAsPassword: Bool {
        return self.count >= AuthenticationManager.passwordMinimumLength
    }

    var isValidEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
