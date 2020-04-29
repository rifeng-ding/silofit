//
//  UIColor+Style.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-24.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

extension UIColor {

    func highlightedColor(withFactor factor: CGFloat? = nil) -> UIColor {

        let lightModeDefaultFactor: CGFloat = 0.75
        let darkModeDefalutFactor: CGFloat = 0.25
        
        if #available(iOS 13.0, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                let defaultFactor: CGFloat
                switch UITraitCollection.userInterfaceStyle {
                case .dark:
                    defaultFactor = darkModeDefalutFactor
                case .light, .unspecified:
                    defaultFactor = lightModeDefaultFactor
                @unknown default:
                    defaultFactor = lightModeDefaultFactor
                }
                return self._highlightedColor(withFactor: factor ?? defaultFactor)
            }
        }
        
        return self._highlightedColor(withFactor: factor ?? lightModeDefaultFactor)
    }
    
    private func _highlightedColor(withFactor factor: CGFloat) -> UIColor {
        
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
