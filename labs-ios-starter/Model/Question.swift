//
//  Question.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Question: Decodable {
    let questionid: Int?
    let surveyId: Int?
    var body: String?
    let type: String?
    let leader: Bool?
    let answers: [Answer]?

    init(questionid: Int?, surveyId: Int?, body: String, type: String?, leader: Bool?, answers: [Answer]?) {
        self.questionid = questionid
        self.surveyId = surveyId
        self.body = body
        self.type = type
        self.leader = leader
        self.answers = answers
    }

    enum CodingKeys: String, CodingKey {
        case questionid, body, type, leader, answers, answer
        case survey, surveyId
        case questionId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.leader = try container.decodeIfPresent(Bool.self, forKey: .leader)

        if let questionId = try container.decodeIfPresent(Int.self, forKey: .questionId) {
            self.questionid = questionId
        } else {
            self.questionid = try container.decodeIfPresent(Int.self, forKey: .questionid)
        }

        var answersContainer = try container.nestedUnkeyedContainer(forKey: .answers)
        var answersArray: [Answer] = []

        while !answersContainer.isAtEnd {
            let answer = try answersContainer.decode(Answer.self)
            answersArray.append(answer)
        }

        self.answers = answersArray

        if let surveyContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .survey) {
            self.surveyId = try surveyContainer.decodeIfPresent(Int.self, forKey: .surveyId)
        } else {
            self.surveyId = nil
        }
    }

    convenience init(body: String, type: String, leader: Bool) {
        self.init(questionid: nil, surveyId: nil, body: body, type: type, leader: leader, answers: nil)
    }

    convenience init(body: String, type: String, leader: Bool, answers: [Answer]) {
        self.init(questionid: nil, surveyId: nil, body: body, type: type, leader: leader, answers: answers)
    }

    convenience init(questionId: Int, body: String) {
        self.init(questionid: questionId, surveyId: nil, body: body, type: nil, leader: nil, answers: nil)
    }
}

extension Question: Encodable {
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(body, forKey: .body)

      if let questionid = questionid {
          try container.encode(questionid, forKey: .questionid)
      }

      if let type = type {
          try container.encode(type, forKey: .type)
      }

      if let leader = leader {
          try container.encode(leader, forKey: .leader)
      }

      if let answers = answers,
          let answer = answers.first {
          try container.encode(answer.body, forKey: .answer)
      }
   }
}
