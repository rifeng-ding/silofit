//
//  TextColor.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-24.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

enum TextColor {

    private enum Name: String {
        case dark = "textDark"
        case mediumDark = "textMediumDark"
    }

    static var dark: UIColor {
        UIColor(named: Name.dark.rawValue)!
    }

    static var mediumDark: UIColor {
        UIColor(named: Name.mediumDark.rawValue)!
    }
}
