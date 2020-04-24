//
//  ReusableView.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-24.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import UIKit
import MapKit

protocol ReusableView {

    static var reuseIdentifer: String { get }
}

extension ReusableView where Self: UIView  {

    static var reuseIdentifer: String {

        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UICollectionViewCell: ReusableView {}

extension MKAnnotationView: ReusableView {}
