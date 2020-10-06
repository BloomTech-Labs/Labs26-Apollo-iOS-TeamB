//
//  Question.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Question: Decodable {
    let questionId: Int?
    let surveyId: Int?
    var body: String?
    let type: String?
    let leader: Bool?

    init(questionId: Int?, surveyId: Int?, body: String, type: String, leader: Bool) {
        self.questionId = questionId
        self.surveyId = surveyId
        self.body = body
        self.type = type
        self.leader = leader
    }

    enum CodingKeys: String, CodingKey {
        case questionId, body, type, leader
        case survey, surveyId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.questionId = try container.decodeIfPresent(Int.self, forKey: .questionId)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.leader = try container.decodeIfPresent(Bool.self, forKey: .leader)

        if let surveyContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .survey) {
            self.surveyId = try surveyContainer.decodeIfPresent(Int.self, forKey: .surveyId)
        } else {
            self.surveyId = nil
        }
    }

    convenience init(body: String, type: String, leader: Bool) {
        self.init(questionId: nil, surveyId: nil, body: body, type: type, leader: leader)
    }
}

extension Question: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(body, forKey: .body)
        try container.encode(type, forKey: .type)
        try container.encode(leader, forKey: .leader)
    }
}
