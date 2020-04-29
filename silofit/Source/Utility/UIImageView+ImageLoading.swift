//
//  UIImageView+ImageLoading.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-24.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView  {

    func loadImage(from url: URL?, completion: ((UIImage?, Error?) -> Void)? = nil) {
        
        self.sd_setImage(with: url, placeholderImage: nil, options: []) { (image, error, _, _) in
            completion?(image, error)
        }
    }
}
