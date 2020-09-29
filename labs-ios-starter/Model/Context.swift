//
//  Context.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Context: Decodable {
    let description: String
    let survey: Survey
    let contextId: Int

    init(description: String, survey: Survey, contextId: Int) {
        self.description = description
        self.survey = survey
        self.contextId = contextId
    }

    enum CodingKeys: String, CodingKey {
        case description, survey, contextId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        self.survey = try container.decode(Survey.self, forKey: .survey)
        self.contextId = try container.decode(Int.self, forKey: .contextId)
    }
}
