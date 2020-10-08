//
//  Answer.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Answer: Decodable {
    let answerId: Int
    let body: String
    let username: String

    init(answerId: Int, body: String, username: String) {
        self.answerId = answerId
        self.body = body
        self.username = username
    }

    enum CodingKeys: String, CodingKey {
        case answerId, body
        case user, username
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
        self.answerId = try container.decode(Int.self, forKey: .answerId)
        self.body = try container.decode(String.self, forKey: .body)
        self.username = try userContainer.decode(String.self, forKey: .username)
    }
}

extension Answer: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var userContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
        try container.encode(answerId, forKey: .answerId)
        try container.encode(body, forKey: .body)
        try userContainer.encode(username, forKey: .username)
    }
}
