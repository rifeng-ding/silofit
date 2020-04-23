//
//  MapViewControllerViewModel.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-23.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

class MapViewControllerViewModel: ViewModel {

    var isValid: Bool {
        
        return spaces.count > 0
    }

    private var spaces: [Space]

    init(spaces:[Space]) {
        self.spaces = spaces
    }
}
