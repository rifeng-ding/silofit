//
//  Space.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import CoreLocation

struct Space: Codable, Identifiable {

    enum Status: String, Codable, CaseDefaultCodable {

        static let defaultCase: Status = .unknown

        case unknown
        case comingSoon = "coming_soon"
        case opened
    }

    let identifier: String?

    let address: String?
    let amenities: [Amenity]?
    let city: String?
    let description: String?
    let equipments: [Equipment]?
    let floor: String?
    let imageUrls: [String]?
    let latitude: Double?
    let longitude: Double?
    let maxCapacity: Int?
    let name: String?
    let openDays: String?
    let openHours: String?
    let rate: Int?
    let slug: String?
    let squareFootage: Int?
    let status: Status
    let timezone: String?

    var coordinate: CLLocationCoordinate2D? {

        guard let latitude = self.latitude, let longitude = self.longitude else {
            return nil
        }

        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return CLLocationCoordinate2DIsValid(coordinate) ? coordinate : nil
    }

    enum CodingKeys: String, CodingKey {
        case address
        case amenities
        case city
        case description
        case equipments
        case floor
        case identifier = "space_id"
        case imageUrls = "image_urls"
        case latitude
        case longitude
        case maxCapacity = "max_capacity"
        case name
        case openDays = "open_days"
        case openHours = "open_hours"
        case rate
        case slug
        case squareFootage = "square_footage"
        case status
        case timezone
    }

    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance? {
        
        guard let spaceCoordinate = self.coordinate else {
            return nil
        }
        let spaceLocation = CLLocation(latitude: spaceCoordinate.latitude,
                                       longitude: spaceCoordinate.longitude)
        let coordinateLocation = CLLocation(latitude: coordinate.latitude,
                                            longitude: coordinate.longitude)
        return spaceLocation.distance(from: coordinateLocation)
    }
}
