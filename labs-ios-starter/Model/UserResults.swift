//
//  UserResults.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 22/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class UserResults: Codable {
    let users: [User]

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var results: [User] = []

        while !container.isAtEnd {
            let user = try container.decode(User.self)
            results.append(user)
        }

        users = results
    }
}
