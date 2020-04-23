//
//  StyledColor.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

final class StyleColor {

    private enum Name: String {
        case border
        case light
        case textFieldBackground
        case theme
    }

    static var light: UIColor {
        return self.color(forName: Name.light.rawValue)!
    }

    static var theme: UIColor {
        return self.color(forName: Name.theme.rawValue)!
    }

    static var border: UIColor {
        return self.color(forName: Name.border.rawValue)!
    }

    static var textFieldBackground: UIColor {
        return self.color(forName: Name.textFieldBackground.rawValue)!
    }

    static private func color(forName name: String) -> UIColor? {

        guard let color = UIColor(named: name, in: Bundle.main, compatibleWith: nil) else {
            print("Cannot find color with name: \(name)")
            return nil
        }
        return color
    }
}

public extension UIColor {

    func highlightedColor(withFactor factor: CGFloat = 0.75) -> UIColor {

        var orginalR: CGFloat = 0
        var orginalG: CGFloat = 0
        var orginalB: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&orginalR, green: &orginalG, blue: &orginalB, alpha: &alpha)

        if orginalR == 1 && orginalG == 1 && orginalB == 1 {

            return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: alpha)
        }

        let r = (1 - orginalR) * factor + orginalR
        let g = (1 - orginalG) * factor + orginalG
        let b = (1 - orginalB) * factor + orginalB

        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}
