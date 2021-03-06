//
//  AuthenticationManager.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthService: AuthService {

    weak var stateUpdatingDelegate: AuthStateUpdatingDelegate?
    static let shared = FirebaseAuthService()

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
                       completion: @escaping ((Result<Void, Error>) -> Void)) {

        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { (_, error) in

            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func login(withEmail email: String,
               password: String,
               completion: @escaping ((Result<Void, Error>) -> Void)) {

        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { (_, error) in

            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
