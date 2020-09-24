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
    var topics: [(String, Int)]? = nil

    init(userid: Int, username: String) {
        self.userid = userid
        self.username = username
    }

    enum CodingKeys: String, CodingKey {
        case userid, username
        case ownedtopics, topics
        case topicId, title
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        userid = try container.decode(Int.self, forKey: .userid)
        username = try container.decode(String.self, forKey: .username)

        var topicsArray = [(String, Int)]()

        // This grabs all the topics for the owned topics object
        var unkeyedOwnedTopicsContainer = try container.nestedUnkeyedContainer(forKey: .ownedtopics)
        let keyedOwnedTopicsContainer = try unkeyedOwnedTopicsContainer.nestedContainer(keyedBy: CodingKeys.self)

        while !unkeyedOwnedTopicsContainer.isAtEnd {
            let title = try keyedOwnedTopicsContainer.decode(String.self, forKey: .title)
            let topicId = try keyedOwnedTopicsContainer.decode(Int.self, forKey: .topicId)

            topicsArray.append((title, topicId))
        }

        // This grabs all the topics from the topics object and combines them with the other topics
        var unkeyedTopicsContainer = try container.nestedUnkeyedContainer(forKey: .topics)
        let keyedTopicsContainer = try unkeyedTopicsContainer.nestedContainer(keyedBy: CodingKeys.self)

        while !unkeyedTopicsContainer.isAtEnd {
            let title = try keyedTopicsContainer.decode(String.self, forKey: .title)
            let topicId = try keyedTopicsContainer.decode(Int.self, forKey: .topicId)

            if !topicsArray.contains(where: { $0.1 == topicId }) {
                topicsArray.append((title, topicId))
            }
        }

        topics = topicsArray
    }
}
