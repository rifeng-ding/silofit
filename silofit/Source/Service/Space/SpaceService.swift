//
//  SpaceService.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-29.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

protocol SpaceService {
    
    func fetchAllSpaces(completion: @escaping (Result<[Space]?, Error>) -> Void)
    
    func fetchSpace(withIdentifer identifer: String,
                           completion: @escaping (Result<Space?, Error>) -> Void)
}
