//
//  AppInfoUtility.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-29.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

class AppInfoUtility {
    
    static var appName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
