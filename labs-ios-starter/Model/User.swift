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
    let avatar: URL?

    init(id: Int, email: String, username: String, password: String, avatar: URL?) {
        self.id = id
        self.email = email
        self.username = username
        self.password = password
        self.avatar = avatar
    }
}
