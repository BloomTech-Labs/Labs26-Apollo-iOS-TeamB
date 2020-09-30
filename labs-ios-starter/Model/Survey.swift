//
//  Survey.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Survey: Decodable {
    let surveyId: Int?
    let topicId: Int?
    var questions: [Question]?

    init(surveyId: Int?, topicId: Int?, questions: [Question]?) {
        self.surveyId = surveyId
        self.topicId = topicId
        self.questions = questions
    }

    convenience init() {
        self.init(surveyId: nil, topicId: nil, questions: nil)
    }

    enum CodingKeys: String, CodingKey {
        case surveyId, questions
        case topic, topicId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.surveyId = try container.decode(Int.self, forKey: .surveyId)
        self.questions = try container.decode([Question].self, forKey: .questions)

        if let topicContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .topic) {
            self.topicId = try topicContainer.decodeIfPresent(Int.self, forKey: .topicId)
        } else {
            self.topicId = nil
        }
    }
}

extension Survey: Encodable {
    enum EncodingCodingKeys: String, CodingKey {
        case questions
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingCodingKeys.self)

        try container.encode(questions, forKey: .questions)
    }
}
