//
//  SpaceListViewControllerViewModel.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-24.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import CoreLocation
import MapKit

class SpaceListViewControllerViewModel: ViewModel {

    var isValid: Bool {

        return spaces.count > 0
    }

    let currentCoordinate: CLLocationCoordinate2D?
    private(set) var spaces: [Space]
    private let distanceFormatter = MKDistanceFormatter()

    init(spaces:[Space], currentCoordinate: CLLocationCoordinate2D?) {

        self.spaces = spaces
        self.currentCoordinate = currentCoordinate

        if let coordinate = currentCoordinate {
            self.spaces.sort { (left, right) -> Bool in
                // space that doesn't have coordinate cannot calucate distance,
                // and it will be put at the end of the list
                guard let leftDistance = left.distance(from: coordinate) else {
                    return false
                }
                guard let rightDistance = right.distance(from: coordinate) else {
                    return true
                }
                return leftDistance < rightDistance
            }
        }
    }

    // MARK: methods for cells
    func numberOfCells() -> Int {

        return self.spaces.count
    }

    func nameLabel(at indexPath: IndexPath) -> String? {

        return self.spaces[indexPath.item].name
    }

    func distanceLabel(at indexPath: IndexPath) -> String? {

        let space = self.spaces[indexPath.item]
        guard
            let coordinate = self.currentCoordinate,
            let distance = space.distance(from: coordinate)
            else {
            return nil
        }

        let formattedDistance = self.distanceFormatter.string(fromDistance: distance)
        return "\(formattedDistance) away"
    }

    func basicInfoLabel(at indexPath: IndexPath) -> String? {

        let space = self.spaces[indexPath.item]
        var labelParts = [String]()

        if let rate = space.rate {
            // TODO: didn't do currency formatting.
            // Technically we can get the locale from the address/coordinate,
            // then get the country code to format the currency
            labelParts.append("FROM $\(rate)/HR")
        }

        if let squareFootage = space.squareFootage {
            labelParts.append("\(squareFootage) SQ.FT.")
        }

        if let maxCapacity = space.maxCapacity {
            labelParts.append("UP TO \(maxCapacity) PEOPLE")
        }

        guard labelParts.count > 0 else {
            return nil
        }
        return labelParts.joined(separator: " • ")
    }

    func imageURL(at indexPath: IndexPath) -> URL? {

        guard let imageURL = self.spaces[indexPath.item].imageUrls?.first else {
            return nil
        }
        return URL(string: imageURL)
    }
}
