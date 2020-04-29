//
//  MockDataUtility.swift
//  silofitTests
//
//  Created by Rifeng Ding on 2020-04-29.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation

class MockDataUtility {
    
    static func loadJSONObjects<T: Codable>(from rawData: String, ofType type: T.Type) -> [T] {

        guard let data = rawData.data(using: .utf8) else {
            print("Raw data is not valid.")
            return [T]()
        }

        var objects: [T]!
        do {
            let decoder = JSONDecoder()
            objects = try decoder.decode([T].self, from: data)
        } catch {
            print(error)
        }
        return objects
    }
}
