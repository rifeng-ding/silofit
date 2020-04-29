//
//  StyledColor.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

enum StyleColor {

    private enum Name: String {
        case background
        case backgroundContent
        case border
        case light
        case pinRed
        case pinGreen
        case scrollViewBackground
        case textFieldBackground
        case theme
    }

    static var background: UIColor {
        UIColor(named: Name.background.rawValue)!
    }

    static var backgroundContent: UIColor {
        UIColor(named: Name.backgroundContent.rawValue)!
    }
    
    static var border: UIColor {
        UIColor(named: Name.border.rawValue)!
    }

    static var light: UIColor {
        UIColor(named: Name.light.rawValue)!
    }

    static var scrollViewBackground: UIColor {
        UIColor(named: Name.scrollViewBackground.rawValue)!
    }

    static var theme: UIColor {
        UIColor(named: Name.theme.rawValue)!
    }

    static var textFieldBackground: UIColor {
        UIColor(named: Name.textFieldBackground.rawValue)!
    }

    static var pinRed: UIColor {
        UIColor(named: Name.pinRed.rawValue)!
    }

    static var pinGreen: UIColor {
        UIColor(named: Name.pinGreen.rawValue)!
    }
}
