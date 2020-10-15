//
//  User.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class User: Decodable {
    let userid: Int
    let username: String

    init(userid: Int, username: String) {
        self.userid = userid
        self.username = username
    }

    enum CodingKeys: String, CodingKey {
        case userid, username
        case owner, user
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let userContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner) {
            userid = try userContainer.decode(Int.self, forKey: .userid)
            username = try userContainer.decode(String.self, forKey: .username)
        } else if let userContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user) {
            userid = try userContainer.decode(Int.self, forKey: .userid)
            username = try userContainer.decode(String.self, forKey: .username)
        } else {
            userid = try container.decode(Int.self, forKey: .userid)
            username = try container.decode(String.self, forKey: .username)
        }
    }
}
