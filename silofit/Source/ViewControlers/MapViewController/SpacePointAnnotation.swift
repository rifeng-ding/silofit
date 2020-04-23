//
//  SpacePointAnnotation.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-23.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import MapKit

class SpacePointAnnotation: MKPointAnnotation {

    var spaceIdentifer: String

    init(spaceIdentifer: String, name: String?, coordinate: CLLocationCoordinate2D) {

        self.spaceIdentifer = spaceIdentifer
        
        super.init()

        self.coordinate = coordinate
        self.title = name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
