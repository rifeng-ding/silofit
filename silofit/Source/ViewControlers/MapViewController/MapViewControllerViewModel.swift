//
//  MapViewControllerViewModel.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-23.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import MapKit

class MapViewControllerViewModel: ViewModelValidation {

    private(set) var spaces: [Space] = []
    let authService: AuthService
    let spaceService: SpaceService
    
    var isValid: Bool {
        
        return spaces.count > 0
    }
    
    init(authService: AuthService, spaceService: SpaceService) {
        
        self.authService = authService
        self.spaceService = spaceService
    }

    private(set) var currentMapAnnotations: [SpacePointAnnotation] = []
    
    func generateMapAnnotations() -> [SpacePointAnnotation] {

        self.currentMapAnnotations = self.spaces.compactMap { (space) -> SpacePointAnnotation? in

            guard
                let coordinate = space.coordinate,
                let spaceIdentifer = space.identifier
            else {
                return nil
            }

            return SpacePointAnnotation(spaceIdentifer: spaceIdentifer,
                                        name: space.name,
                                        coordinate: coordinate)
        }
        
        return self.currentMapAnnotations
    }

    func annotationViewColor(forSpaceWithIdentifer spaceIdentifer: String) -> UIColor {

        let space = self.spaces.first { $0.identifier == spaceIdentifer }
        guard let targetSpace = space else {
            return StyleColor.pinRed
        }
        switch targetSpace.status {
        case .comingSoon, .unknown:
            return StyleColor.pinRed
        case .opened:
            return StyleColor.pinGreen
        }
    }
    
    func loadSpaces(completion: @escaping (Result<Void, Error>) -> Void) {

        self.spaceService.fetchAllSpaces { (result) in
            switch result {
            case .success(let spaces):
                self.spaces = spaces ?? []
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))               
            }
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        
        switch self.authService.logout() {
        case .success(_):
            completion(.success(()))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
