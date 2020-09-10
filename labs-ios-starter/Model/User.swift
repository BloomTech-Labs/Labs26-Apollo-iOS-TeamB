//
//  User.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class User: Codable {
    let id: Int
    let email: String
    let username: String
    let password: String

    init(id: Int, email: String, username: String, password: String) {
        self.id = id
        self.email = email
        self.username = username
        self.password = password
    }
}
