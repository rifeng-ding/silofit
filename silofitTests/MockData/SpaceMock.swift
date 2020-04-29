//
//  SpaceMock.swift
//  silofitTests
//
//  Created by Rifeng Ding on 2020-04-29.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
@testable import Silofit

class SpaceMock {
    
    static var spaces: [Space] {
        
        return MockDataUtility.loadJSONObjects(from: Self.rawSpaces, ofType: Space.self)
    }
    
    // This can also be stored and read from a txt file
    static private let rawSpaces = """
    [
        {
          "address" : "#303-2075 Robert-Bourassa Blvd Montréal, QC",
          "amenities" : [ "shower", "wifi", "speakers", "tv", "charging_station", "storage_locker", "netflix", "fruit", "water", "hair_dryer", "scale", "diffuser", "massage_cream", "shampoo", "hand_soap", "body_lotion", "body_cleanser", "conditioner", "whiteboard", "selfie_remote", "selfie_holder", "security_camera", "first_aid_kit", "emergency_pendant" ],
          "city" : "Montreal",
          "description" : "This Silo is located Downtown, with direct access from McGill Metro Station. It accommodates up to 5 people, making it the perfect spot for working out with friends, or for professionals in the area. Silofit also welcomes trainers to bring their clients for this private and special experience.",
          "equipments" : [ "treadmill", "rack", "rower", "cable_machine", "bench", "dumbbells", "power_blocks", "kettle_bells", "massage_table", "trx", "boxing", "ab_wheel", "battle_rope", "jump_rope", "aerobic_step", "box", "cone", "mobility_stick", "agility_ladder", "medicine_balls", "slam_balls", "bosu_ball", "exercise_balls", "lacrosse_ball", "resistance_bands", "foam_roller", "yoga_mats", "yoga_blocks", "yoga_wheels", "meditation_cushions" ],
          "floor" : "3rd",
          "image_urls" : [ "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F303-2075-robert-bourassa%2Fgym01.jpg?alt=media&token=a2aebf86-cbbd-4229-9bf4-9212a9684300", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F303-2075-robert-bourassa%2Fgym02.jpg?alt=media&token=5054d7fd-3c76-4252-92cd-20e7b3586a9b", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F303-2075-robert-bourassa%2Fgym03.jpg?alt=media&token=9bad0e3b-7756-4b5b-8de6-e1a4f878ea8a", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F303-2075-robert-bourassa%2Fgym05.jpg?alt=media&token=dbe22748-b77f-4165-b0da-5ff8e4a86fd0", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F303-2075-robert-bourassa%2Fgym06.jpg?alt=media&token=617350e0-1ff1-4007-8729-3b69d8c8cba9", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F303-2075-robert-bourassa%2Fflorrplan2075.jpg?alt=media&token=222ed7f7-e56b-409e-84ab-3a18cefa99ef" ],
          "latitude" : 45.504886,
          "longitude" : -73.572702,
          "max_capacity" : 4,
          "name" : "2075 Robert-Bourassa Blvd",
          "open_days" : "Mon - Fri",
          "open_hours" : "06:00 am - 11:30 pm",
          "rate" : 5,
          "slug" : "mtl_303_2075_robert_bourassa",
          "space_id" : "-KhFXM52USuaalkasd09",
          "square_footage" : 580,
          "status" : "opened",
          "timezone" : "America/Montreal"
        },
        {
          "address" : "#100-1440 Saint Catherine St W. Montréal, QC",
          "amenities" : [ "shower", "towels", "wifi", "speakers", "tv", "charging_station", "netflix", "fruit", "water", "hair_dryer", "shampoo", "hand_soap", "body_lotion", "body_cleanser", "conditioner", "whiteboard", "selfie_remote", "selfie_holder", "first_aid_kit", "emergency_pendant" ],
          "city" : "Montreal",
          "description" : "In the heart of downtown, this Silo is near two Metro Stations - Guy-Concordia and Lucien L’Allier. This 850 sqft. space fits up to 8 people, making it the perfect spot for fitness classes, group sessions, or working out with friends! This Silo is unique featuring two showers, two changing rooms, and tons of open space!",
          "equipments" : [ "skier", "rack", "rower", "airbike", "cable_machine", "bench", "dumbbells", "power_blocks", "kettle_bells", "massage_table", "trx", "boxing", "boxing_bag", "equalizer_bars", "ab_wheel", "battle_rope", "jump_rope", "aerobic_step", "box", "cone", "agility_ladder", "medicine_balls", "slam_balls", "bosu_ball", "exercise_balls", "lacrosse_ball", "gliding_discs", "resistance_bands", "foam_roller", "mats", "yoga_mats", "yoga_blocks", "yoga_straps" ],
          "floor" : "Ground",
          "image_urls" : [ "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F100_1440_saint_catherine_w%2Fsilopreview02.jpg?alt=media&token=c79aa365-94ed-49fb-b362-eecb895e38e4", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F100_1440_saint_catherine_w%2Fsilopreview01.jpg?alt=media&token=6889dea9-4140-4773-98ad-34e584351b87", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F100_1440_saint_catherine_w%2Fsilopreview03.jpg?alt=media&token=cc8ffa05-41c7-447e-9f05-95443d177164", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F100_1440_saint_catherine_w%2Fsilopreview04.jpg?alt=media&token=aeea11bf-c82e-4f1c-aaed-39bed4382fa2", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F100_1440_saint_catherine_w%2Fsilopreview05.jpg?alt=media&token=b633383b-615b-4b01-b0c6-d0e300dbf253", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F100_1440_saint_catherine_w%2Fflorrplan1440.jpg?alt=media&token=75ca7a8e-8c44-44b8-b9fb-0c5886f7aaf3" ],
          "latitude" : 45.496223,
          "longitude" : -73.57652,
          "max_capacity" : 8,
          "name" : "1440 Saint-Catherine W",
          "open_days" : "Mon - Sun",
          "open_hours" : "06:00 am - 11:30 pm",
          "rate" : 20,
          "slug" : "mtl_100_1440_saint_catherine_w",
          "space_id" : "-KhFXM52USu2f_asgdne",
          "square_footage" : 850,
          "status" : "coming_soon",
          "timezone" : "America/Montreal"
        },
        {
          "address" : "#511-3575 Saint-Laurent Blvd, Montreal, QC",
          "amenities" : [ "shower", "towels", "wifi", "speakers", "tv", "charging_station", "storage_locker", "netflix", "fruit", "water", "hair_dryer", "diffuser", "massage_cream", "shampoo", "hand_soap", "body_lotion", "body_cleanser", "conditioner", "whiteboard", "selfie_remote", "selfie_holder", "security_camera", "first_aid_kit", "emergency_pendant" ],
          "city" : "Montreal",
          "description" : "Located in Milton Park, this Silo is right by three Metro Stations - Saint-Laurent, Sherbrooke, and Place-des-Arts. Up to 5 people can use the space at once, making it a great spot for group workouts, or private sessions. We encourage trainers to bring their clients for this unique, private experience.",
          "equipments" : [ "treadmill", "rack", "rower", "airbike", "cable_machine", "bench", "dumbbells", "power_blocks", "kettle_bells", "massage_table", "trx", "boxing", "ab_wheel", "battle_rope", "jump_rope", "aerobic_step", "box", "cone", "agility_ladder", "medicine_balls", "slam_balls", "bosu_ball", "exercise_balls", "lacrosse_ball", "gliding_discs", "resistance_bands", "foam_roller", "yoga_mats", "yoga_blocks", "yoga_straps" ],
          "floor" : "5th",
          "image_urls" : [ "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview01.jpg?alt=media&token=aef81efd-c061-417a-adc3-667c19a6439f", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview02.jpg?alt=media&token=6fee5f33-f5e2-4200-9d30-353d9ac12dec", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview03.jpg?alt=media&token=afabcf0f-5c1b-4d49-a94b-d1d018cf273c", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview04.jpg?alt=media&token=46661012-a625-4c32-a8aa-81fbdd80c620", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview05.jpg?alt=media&token=030dff33-4707-47db-b652-96e0e16a82f1", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview06.jpg?alt=media&token=d2eff967-63a3-4fc3-8f82-c23013d83540", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fflorrplan3575.jpg?alt=media&token=194f3fba-5eb1-4d82-beef-6dc39708d6f8" ],
          "latitude" : 45.5139292,
          "longitude" : -73.5721795,
          "max_capacity" : 5,
          "name" : "3575 Saint-Laurent Blvd",
          "open_days" : "Mon - Sun",
          "open_hours" : "6:00 am - 11:30 pm",
          "rate" : 10,
          "slug" : "mtl_511_3575_saint_laurent",
          "space_id" : "-LinovQaecdQEFAcf42ewds",
          "square_footage" : 550,
          "status" : "opened",
          "timezone" : "America/Montreal"
        },
        {
          "address" : "#511-215 Spadina Ave, Toronto, ON",
          "amenities" : [ "shower", "towels", "wifi", "speakers", "tv", "charging_station", "storage_locker", "netflix", "fruit", "water", "hair_dryer", "diffuser", "massage_cream", "shampoo", "hand_soap", "body_lotion", "body_cleanser", "conditioner", "whiteboard", "selfie_remote", "selfie_holder", "security_camera", "first_aid_kit", "emergency_pendant" ],
          "city" : "Toronto",
          "description" : "Located in Milton Park, this Silo is right by three Metro Stations - Saint-Laurent, Sherbrooke, and Place-des-Arts. Up to 5 people can use the space at once, making it a great spot for group workouts, or private sessions. We encourage trainers to bring their clients for this unique, private experience.",
          "equipments" : [ "treadmill", "rack", "rower", "airbike", "cable_machine", "bench", "dumbbells", "power_blocks", "kettle_bells", "massage_table", "trx", "boxing", "ab_wheel", "battle_rope", "jump_rope", "aerobic_step", "box", "cone", "agility_ladder", "medicine_balls", "slam_balls", "bosu_ball", "exercise_balls", "lacrosse_ball", "gliding_discs", "resistance_bands", "foam_roller", "yoga_mats", "yoga_blocks", "yoga_straps" ],
          "floor" : "Ground",
          "image_urls" : [ "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview01.jpg?alt=media&token=aef81efd-c061-417a-adc3-667c19a6439f", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview02.jpg?alt=media&token=6fee5f33-f5e2-4200-9d30-353d9ac12dec", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview03.jpg?alt=media&token=afabcf0f-5c1b-4d49-a94b-d1d018cf273c", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview04.jpg?alt=media&token=46661012-a625-4c32-a8aa-81fbdd80c620", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview05.jpg?alt=media&token=030dff33-4707-47db-b652-96e0e16a82f1", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fsilopreview06.jpg?alt=media&token=d2eff967-63a3-4fc3-8f82-c23013d83540", "https://firebasestorage.googleapis.com/v0/b/silofit-dev-2a08d.appspot.com/o/spaces%2F511_3575_saint_laurent%2Fflorrplan3575.jpg?alt=media&token=194f3fba-5eb1-4d82-beef-6dc39708d6f8" ],
          "latitude" : 43.650781,
          "longitude" : -79.39663,
          "max_capacity" : 5,
          "name" : "215 Spadina Ave",
          "open_days" : "Mon - Sun",
          "open_hours" : "6:00 am - 11:30 pm",
          "rate" : 10,
          "slug" : "mtl_b06_215_spadina",
          "space_id" : "-TinovQadaAEfBTPsd234SDS",
          "square_footage" : 550,
          "status" : "coming_soon",
          "timezone" : "America/Montreal"
        }
    ]
    """
}
