//
//  MockAuthService.swift
//  silofitTests
//
//  Created by Rifeng Ding on 2020-04-29.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
@testable import Silofit

class MockAuthService: AuthService {
    
    enum MockAuthError: Error {
        
        case accountCreationFailure
        case loginFailure
        case logoutFailure
    }
    
    weak var stateUpdatingDelegate: AuthStateUpdatingDelegate?
    
    var shouldAccountCreationSucceed: Bool = true
    var shouldLoginSucceed: Bool = true
    var shouldLogoutSucceed: Bool = true
    var hasLoggedIn: Bool = false
    
    var isLogin: Bool {
        
        return self.hasLoggedIn && self.shouldLoginSucceed
    }
    
    func logout() -> Result<Void, Error> {
        
        self.hasLoggedIn = false

        return shouldLogoutSucceed ? .success(()) : .failure(MockAuthError.logoutFailure)
    }
    
    func createAccount(withEmail email: String, password: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        if self.shouldAccountCreationSucceed {
            completion(.success(()))
        } else {
            completion(.failure(MockAuthError.accountCreationFailure))
        }
    }
    
    func login(withEmail email: String, password: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        if self.shouldLoginSucceed {
            completion(.success(()))
        } else {
            completion(.failure(MockAuthError.loginFailure))
        }
    }
}
