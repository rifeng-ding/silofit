//
//  AuthService.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-29.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

protocol AuthStateUpdatingDelegate: class {

    func authStateDidChange()
}

protocol AuthService {
    
    var stateUpdatingDelegate: AuthStateUpdatingDelegate? { set get }
    var isLogin: Bool { get }
    
    func logout() -> Result<Void, Error>
    
    func createAccount(withEmail email: String,
                       password: String,
                       completion: @escaping ((Error?) -> Void))
    
    func login(withEmail email: String,
               password: String,
               completion: @escaping ((Error?) -> Void))
}
