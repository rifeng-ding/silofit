//
//  StyledNavigationController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class StyledNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {

        super.init(rootViewController: rootViewController)
        self.navigationBar.tintColor = StyleColor.theme
        self.navigationBar.isTranslucent = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
