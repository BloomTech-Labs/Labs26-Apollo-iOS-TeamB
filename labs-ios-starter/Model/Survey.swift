//
//  Survey.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Survey: Decodable {
    let surveyId: Int
    let topicId: Int
    let questions: [Question]

    init(surveyId: Int, topicId: Int, questions: [Question]) {
        self.surveyId = surveyId
        self.topicId = topicId
        self.questions = questions
    }

    enum CodingKeys: String, CodingKey {
        case surveyId, questions
        case topic, topicId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let topicContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .topic)

        self.surveyId = try container.decode(Int.self, forKey: .surveyId)
        self.topicId = try topicContainer.decode(Int.self, forKey: .topicId)
        self.questions = try container.decode([Question].self, forKey: .questions)
    }
}

extension Survey: Encodable {
    enum EncodingCodingKeys: String, CodingKey {
        case defaultsurvey
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingCodingKeys.self)

        try container.encode(questions, forKey: .defaultsurvey)
    }
}
