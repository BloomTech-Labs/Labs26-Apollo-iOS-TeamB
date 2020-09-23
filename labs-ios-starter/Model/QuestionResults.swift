//
//  QuestionResults.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 22/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class QuestionResults: Codable {
    let questions: [Question]

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var results: [Question] = []

        while !container.isAtEnd {
            let question = try container.decode(Question.self)
            results.append(question)
        }

        questions = results
    }
}
