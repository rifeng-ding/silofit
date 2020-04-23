//
//  StyledButton.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class StyledButton: UIButton {

    enum Style {
        case light
        case dark

        var titleColor: UIColor {
            switch self {
            case .light:
                return StyleColor.theme
            case .dark:
                return StyleColor.light
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .light:
                return StyleColor.light
            case .dark:
                return StyleColor.theme
            }
        }

        var hasBorder: Bool {
            switch self {
            case .light:
                return true
            case .dark:
                return false
            }
        }
    }

    static let defaultHeight: CGFloat = 60
    
    let style: Style

    init(style: Style,
         title: String) {

        self.style = style
        super.init(frame: .zero)

        self.setupUI(forStyle: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
    }

    private func setupUI(forStyle style: Style) {

        self.layer.cornerRadius = CornerRadius.regular
        let titleColor = style.titleColor
        let backgroundColor = style.backgroundColor
        let titleHighlightColor = titleColor.highlightedColor()
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(titleHighlightColor, for: .highlighted)
        self.setTitleColor(titleHighlightColor, for: .disabled)

        let backgroundHighlightColor = backgroundColor.highlightedColor()
        self.setBackgroundColor(backgroundColor, for: .normal)
        self.setBackgroundColor(backgroundHighlightColor, for: .highlighted)
        self.setBackgroundColor(backgroundHighlightColor, for: .disabled)

        if style.hasBorder {
            self.layer.borderWidth = BorderWidth.regular
            self.layer.borderColor = style.titleColor.cgColor
        }

        self.heightAnchor.constraint(equalToConstant: Self.defaultHeight).isActive = true
        self.layer.cornerRadius = Self.defaultHeight / 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var isEnabled: Bool {

        didSet {
            self.updateBorderColorIfNeeded(isHighlighted: !self.isEnabled)
        }
    }

    override public var isHighlighted: Bool {

        didSet {
            self.updateBorderColorIfNeeded(isHighlighted: self.isHighlighted)
        }
    }

    private func updateBorderColorIfNeeded(isHighlighted: Bool) {

        if self.style.hasBorder {
            let titleColor = self.style.titleColor
            let borderColor = isHighlighted ? titleColor.highlightedColor() : titleColor
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@objc public extension UIButton {

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {

        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {

            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: state)
        }
    }
}
