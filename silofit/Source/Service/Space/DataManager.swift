//
//  FirebaseDataManager.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

final class FirebaseSpaceService {

    static let ref: DatabaseReference = Database.database().reference()

    static func fetchAllSpaces(completion: @escaping (Result<[Space]?, Error>) -> Void) {

        self.ref.child("spaces").observe(.value, with: { (dataSnapshot) in

            let dictionaryValue = dataSnapshot.value as? NSDictionary
            let rawSpaces = dictionaryValue?.allValues

            guard rawSpaces != nil else {
                completion(.success(nil))
                return
            }

            do {
                let spaces = try FirebaseDecoder().decode([Space].self, from: (rawSpaces as Any))
                completion(.success(spaces))
            } catch {
                completion(.failure(error))
            }
        }, withCancel: { (error) in
            completion(.failure(error))
        })
    }

    static func fetchSpace(withIdentifer identifer: String,
                           completion: @escaping (Result<Space?, Error>) -> Void) {

        self.ref.child("spaces/\(identifer)").observe(.value, with: { (dataSnapshot) in

            guard let rawSpace = dataSnapshot.value else {
                completion(.success(nil))
                return
            }
            do {
                let space = try FirebaseDecoder().decode(Space.self, from: rawSpace)
                completion(.success(space))
            } catch {
                completion(.failure(error))
            }
            // TODO: FirebaseDecoder from Pod works well, but should look into how it works!
            /*
            let dictionaryValue = dataSnapshot.value as? [String: Codable]
            guard let jsonData = dictionaryValue?.jsonData else {
                completion(.success(nil))
                return
            }
            do {
                let spaces = try JSONDecoder().decode(Space.self, from: jsonData)
                print(spaces)
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
             */
        }, withCancel: { (error) in
            completion(.failure(error))
        })
    }
}

/*
extension Collection {
    //Designed for use with Dictionary and Array types
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
*/
