//
//  MapViewControllerViewModel.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-23.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import MapKit

class MapViewControllerViewModel: ViewModel {

    var isValid: Bool {
        
        return spaces.count > 0
    }

    private var spaces: [Space]

    init(spaces:[Space]) {
        self.spaces = spaces
    }

    lazy private(set) var mapAnnotations: [MKPointAnnotation] = {

        return self.spaces.compactMap { (space) -> MKPointAnnotation? in

            guard let coordinate = space.coordinate else {
                return nil
            }
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = coordinate
            pointAnnotation.title = space.name
            return pointAnnotation
        }
    }()
}
