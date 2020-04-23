//
//  Equipment.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

enum Equipment: String, CaseDefaultCodable {

    static let defaultCase: Equipment = .unknown

    case unknown

    case abWheel = "ab_wheel"
    case aerobicStep = "aerobic_step"
    case agilityLadder = "agility_ladder"
    case airbike
    case battleRope = "battle_rope"
    case bench
    case bosuBall = "bosu_ball"
    case box
    case boxing
    case boxingBag = "boxing_bag"
    case cableMachine = "cable_machine"
    case cone
    case dumbbells
    case equalizerBars = "equalizer_bars"
    case exerciseBalls = "exercise_balls"
    case foamRoller = "foam_roller"
    case glidingDiscs = "gliding_discs"
    case jumpRope = "jump_rope"
    case kettleBells = "kettle_bells"
    case lacrosseBall = "lacrosse_ball"
    case massageTable = "massage_table"
    case mats
    case medicineBalls = "medicine_balls"
    case meditationCushions = "meditation_cushions"
    case mobilityStick = "mobility_stick"
    case powerBlocks = "power_blocks"
    case rack
    case resistanceBands = "resistance_bands"
    case rower
    case skier
    case slamBalls = "slam_balls"
    case treadmill
    case trx
    case yogaBlocks = "yoga_blocks"
    case yogaNats = "yoga_mats"
    case yogaStraps = "yoga_straps"
    case yogaWheels = "yoga_wheels"
}
