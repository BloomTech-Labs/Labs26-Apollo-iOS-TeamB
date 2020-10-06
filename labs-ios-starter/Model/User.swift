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
    var topics: [(String, Int)]?
    init(userid: Int, username: String) {
        self.userid = userid
        self.username = username
    }
    enum CodingKeys: String, CodingKey {
        case user, userid, username
        case ownedtopics, topics
        case topicId, title
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .user)
      
        userid = try userContainer.decode(Int.self, forKey: .userid)
        username = try userContainer.decode(String.self, forKey: .username)

        if var unkeyedOwnedTopicsContainer = try? container.nestedUnkeyedContainer(forKey: .ownedtopics) {
            var topicsArray = [(String, Int)]()

            // This grabs all the topics for the owned topics object
            let keyedOwnedTopicsContainer = try unkeyedOwnedTopicsContainer.nestedContainer(keyedBy: CodingKeys.self)

            while !unkeyedOwnedTopicsContainer.isAtEnd {
                guard let title = try keyedOwnedTopicsContainer.decodeIfPresent(String.self, forKey: .title),
                      let topicId = try keyedOwnedTopicsContainer.decodeIfPresent(Int.self, forKey: .topicId) else { break }

                topicsArray.append((title, topicId))
            }

            // This grabs all the topics from the topics object and combines them with the other topics
            var unkeyedTopicsContainer = try container.nestedUnkeyedContainer(forKey: .topics)
            let keyedTopicsContainer = try unkeyedTopicsContainer.nestedContainer(keyedBy: CodingKeys.self)

            while !unkeyedTopicsContainer.isAtEnd {
                guard let title = try keyedTopicsContainer.decodeIfPresent(String.self, forKey: .title),
                      let topicId = try keyedTopicsContainer.decodeIfPresent(Int.self, forKey: .topicId) else { break }

                if !topicsArray.contains(where: { $0.1 == topicId }) {
                    topicsArray.append((title, topicId))
                }
            }

            topics = topicsArray
        }
    }
}
