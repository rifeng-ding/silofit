//
//  BaseViewController.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var keyWindowSafeAreaInsets: UIEdgeInsets {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return .zero
        }

        return keyWindow.safeAreaInsets
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    /// Method to setup the UI on the view controller programatically.
    ///
    /// Subclass should implemenet this method to setup its UI programatically.
    /// This method is called by BaseViewController in its ViewDidLoad.
    func setupUI() {
        // Empty, should be overridden by subclasses.
    }
}
