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

    var isValid: Bool {
        
        return spaces.count > 0
    }

    private(set) var spaces: [Space]

    init(spaces:[Space]) {
        self.spaces = spaces
    }

    lazy private(set) var mapAnnotations: [SpacePointAnnotation] = {

        return self.spaces.compactMap { (space) -> SpacePointAnnotation? in

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
    }()

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
}
