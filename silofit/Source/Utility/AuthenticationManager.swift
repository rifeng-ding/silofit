//
//  AuthenticationManager.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol AuthStateUpdatingDelegate: class {

    func authStateDidChange()
}

final class AuthenticationManager {

    weak var stateUpdatingDelegate: AuthStateUpdatingDelegate?
    static let shared = AuthenticationManager()

    var authStateChangeHandler: AuthStateDidChangeListenerHandle?
    init() {
        self.authStateChangeHandler = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.stateUpdatingDelegate?.authStateDidChange()
        }
    }

    deinit {
        if let authStateChangeHandler = authStateChangeHandler {
            Auth.auth().removeStateDidChangeListener(authStateChangeHandler)
        }
    }

    var isLogin: Bool {
        
        return Auth.auth().currentUser != nil
    }

    func logout() -> Result<Void, Error> {

        do {
            try Auth.auth().signOut()
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func createAccount(withEmail email: String,
                       password: String,
                       completion: @escaping ((Error?) -> Void)) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { (_, error) in
            completion(error)
        }
    }

    func login(withEmail email: String,
               password: String,
               completion: @escaping ((Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            completion(error)
        }
    }
}

extension String {

    var isValidEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
