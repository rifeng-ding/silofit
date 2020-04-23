//
//  Space.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

struct Space: Codable, Identifiable {

    enum Status: String, Codable {

        case unknown
        case opened
        case comingSoon
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
}
