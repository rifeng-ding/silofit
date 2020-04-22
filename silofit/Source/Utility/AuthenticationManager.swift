//
//  AuthenticationManager.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

final class AuthenticationManager {

    static let shared = AuthenticationManager()

    // TODO: mock for now
    var isLogin: Bool {
        
        return true
    }

    func logout(_ completion: (Error?) -> Void) {

        // mock
        completion(nil)
    }
}
