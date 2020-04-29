//
//  StyledTextField.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-23.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class StyledTextField: UITextField {

    static let defaultHeight: CGFloat = 60

    init(placeholder: String? = nil, text: String? = nil) {
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = CornerRadius.regular

        self.heightAnchor.constraint(equalToConstant: Self.defaultHeight).isActive = true

        self.placeholder = placeholder
        self.text = text
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        self.setupColors()
    }
    
    private func setupColors() {
        
        self.backgroundColor = StyleColor.textFieldBackground
        self.layer.borderColor = StyleColor.border.cgColor
    }

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Spacing.large, dy: 0)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Spacing.large , dy: 0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: Spacing.large, dy: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
