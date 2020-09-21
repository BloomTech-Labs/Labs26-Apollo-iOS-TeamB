//
//  User.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class User: Codable {
    let userid: Int
    let email: String
    let username: String
    var avatar: URL? = nil

    enum CodingKeys: String, CodingKey {
        case userid, username, avatar
        case email = "primaryemail"
    }

    init(userid: Int, email: String, username: String, avatar: URL?) {
        self.userid = userid
        self.email = email
        self.username = username
        self.avatar = avatar
    }
}
