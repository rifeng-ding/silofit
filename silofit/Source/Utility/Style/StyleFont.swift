//
//  StyleFont.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-24.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

enum StyleFont {

    static var title: UIFont {
        return UIFont.preferredFont(forTextStyle: .title1)
    }

    static var subtitle: UIFont {
        return UIFont.preferredFont(forTextStyle: .subheadline)
    }

    static var caption: UIFont {
        return UIFont.preferredFont(forTextStyle: .caption1)
    }
}
