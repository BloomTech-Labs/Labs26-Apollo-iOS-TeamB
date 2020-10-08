//
//  AnswerResults.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 08/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class AnswerResults: Decodable {
    let results: [Answer]

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var results: [Answer] = []

        while !container.isAtEnd {
            let answer = try container.decode(Answer.self)
            results.append(answer)
        }

        self.results = results
    }

}
