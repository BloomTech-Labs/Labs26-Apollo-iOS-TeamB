//
//  TopicResults.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 15/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class TopicResults: Codable {
    let results: [Topic]

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var resultsArray: [Topic] = []

        while !container.isAtEnd {
            let topic = try container.decode(Topic.self)
            resultsArray.append(topic)
        }

        results = resultsArray
    }
}
