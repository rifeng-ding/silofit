//
//  ViewModelValidation.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-23.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

protocol ViewModelValidation {

    /// A one-stop flag to indicate whether the view model is valid.
    var isValid: Bool { get }
}
