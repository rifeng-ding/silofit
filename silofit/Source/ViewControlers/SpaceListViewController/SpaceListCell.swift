//
//  SpaceListCell.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-24.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class SpaceListCell: UICollectionViewCell {

    private var widthConstraint: NSLayoutConstraint?

    var width: CGFloat = 0 {
        willSet {
            self.widthConstraint?.constant = newValue
        }
    }

    let nameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleFont.title
        label.textColor = TextColor.dark
        return label
    }()

    let infoLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleFont.caption
        label.textColor = TextColor.mediumDark
        return label
    }()

    let distanceLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleFont.subtitle
        label.textColor = TextColor.dark
        return label
    }()

    let imageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let stackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.small
        return stackView
    }()

    override init(frame: CGRect) {

        super.init(frame: frame)

        self.backgroundColor = StyleColor.backgroundContent

        self.imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 9/16).isActive = true
        self.widthConstraint = self.imageView.widthAnchor.constraint(equalToConstant: 320)
        self.widthConstraint?.isActive = true
        self.contentView.addSubview(self.imageView)

        self.stackView.addArrangedSubview(self.infoLabel)
        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.distanceLabel)
        self.contentView.addSubview(self.stackView)

        let views = [
            "imageView": self.imageView,
            "stackView": self.stackView
        ]

        let metrics = [
            "inset": Spacing.large
        ]

        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0@999-[imageView]-(inset@999)-[stackView]-(inset@999)-|",
            options: [],
            metrics: metrics,
            views: views)
        self.contentView.addConstraints(verticalConstraints)

        let imageViewHorizentalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0@999-[imageView]-0@999-|",
            options: [],
            metrics: metrics,
            views: views)
        self.contentView.addConstraints(imageViewHorizentalConstraint)

        let stackViewHorizentalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(inset@999)-[stackView]-(inset@999)-|",
            options: [],
            metrics: metrics,
            views: views)
        self.contentView.addConstraints(stackViewHorizentalConstraint)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
