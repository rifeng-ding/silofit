//
//  FirebaseSpaceService.swift
//  silofit
//
//  Created by Rifeng Ding on 2020-04-22.
//  Copyright © 2020 Rifeng Ding. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase

final class FirebaseSpaceService: SpaceService {

    let ref: DatabaseReference = Database.database().reference()

    func fetchAllSpaces(completion: @escaping (Result<[Space]?, Error>) -> Void) {

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

    func fetchSpace(withIdentifer identifer: String,
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
        }, withCancel: { (error) in
            completion(.failure(error))
        })
    }
}
