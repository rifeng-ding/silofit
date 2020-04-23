//
//  Amenity.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

enum Amenity: String, CaseDefaultCodable {

    static var defaultCase: Amenity = .unknown

    case unknown

    case bodyCleanser = "body_cleanser"
    case bodyLotion = "body_lotion"
    case conditioner = "conditioner"
    case chargingStation = "charging_station"
    case diffuser
    case emergencyPendant = "emergency_pendant"
    case firstAidKit = "first_aid_kit"
    case fruit
    case hairDryer = "hair_dryer"
    case handSoap = "hand_soap"
    case massageCream = "massage_cream"
    case netflix
    case scale
    case securityCamera = "security_camera"
    case shampoo
    case selfieHolder = "selfie_holder"
    case selfieRemote = "selfie_remote"
    case shower
    case speakers
    case storageLocker = "storage_locker"
    case tv
    case water
    case whiteboard
    case wifi
}
