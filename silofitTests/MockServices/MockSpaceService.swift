//
//  MockSpaceService.swift
//  silofitTests
//
//  Created by Rifeng Ding on 2020-04-29.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
@testable import Silofit

class MockSpaceService: SpaceService {
    
    enum MockSpaceServiceError: Error {
        
        case requestFailed
    }
    
    let mockSpaces: [Space]
    var hasSpaces = true
    var returnError = false
    
    init() {
        self.mockSpaces = SpaceMock.spaces
    }
    
    func fetchAllSpaces(completion: @escaping (Result<[Space]?, Error>) -> Void) {
     
        //Note: so far, only suceess case is tested
        if returnError {
            completion(.failure(MockSpaceServiceError.requestFailed))
        } else {
            completion(.success(self.hasSpaces ? self.mockSpaces: []))
        }
    }
    
    func fetchSpace(withIdentifer identifer: String, completion: @escaping (Result<Space?, Error>) -> Void) {
        
        fatalError("This mock method is not implemented yet")
    }
}
