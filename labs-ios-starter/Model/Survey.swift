//
//  Survey.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Survey: Decodable {
    let surveyid: Int?
    let topicId: Int?
    var questions: [Question]?
    let createdDate: String?

    init(surveyid: Int?, topicId: Int?, questions: [Question]?, createdDate: String?) {
        self.surveyid = surveyid
        self.topicId = topicId
        self.questions = questions
        self.createdDate = createdDate
    }

    convenience init() {
        self.init(surveyid: nil, topicId: nil, questions: nil, createdDate: nil)
    }

    enum CodingKeys: String, CodingKey {
        case surveyid, questions, createdDate
        case topic, topicId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.surveyid = try container.decode(Int.self, forKey: .surveyid)
        self.questions = try container.decode([Question].self, forKey: .questions)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)

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
