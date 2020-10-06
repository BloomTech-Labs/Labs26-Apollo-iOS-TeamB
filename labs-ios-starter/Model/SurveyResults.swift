//
//  SurveyResults.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 22/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class SurveyResults: Codable {
    let surveys: [Survey]

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var results: [Survey] = []

        while !container.isAtEnd {
            let survey = try container.decode(Survey.self)
            results.append(survey)
        }

        surveys = results
    }
}
