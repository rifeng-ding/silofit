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

    let spaces: [Space]
    let distances: [CLLocationDistance]?
    let distanceFormatter = MKDistanceFormatter()

    init(spaces:[Space], currentCoordinate: CLLocationCoordinate2D?) {

        self.spaces = spaces

        if let currentCoordinate = currentCoordinate {
            self.distances = spaces.compactMap { (space) -> CLLocationDistance? in
                guard let spaceCoordinate = space.coordinate else {
                    return nil
                }
                let spaceLocation = CLLocation(latitude: spaceCoordinate.latitude,
                                               longitude: spaceCoordinate.longitude)
                let currentLocation = CLLocation(latitude: currentCoordinate.latitude,
                                                 longitude: currentCoordinate.longitude)
                return spaceLocation.distance(from: currentLocation)
            }
        } else {
            self.distances = nil
        }
    }

    func space(at indexPath: IndexPath) -> Space {

        return self.spaces[indexPath.item]
    }

    // MARK: methods for cells
    func numberOfCells() -> Int {

        return self.spaces.count
    }

    func nameLabel(at indexPath: IndexPath) -> String? {

        return self.spaces[indexPath.item].name
    }

    func distanceLabel(at indexPath: IndexPath) -> String? {

        guard let distances = self.distances else {
            return nil
        }

        let distance = distances[indexPath.item]
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
