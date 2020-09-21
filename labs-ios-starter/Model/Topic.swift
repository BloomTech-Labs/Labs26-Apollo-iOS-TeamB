//
//  Topic.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Topic: Codable {
    let topicId: Int?
    let userId: Int?
    let title: String
    let surveys: [Int]?
    let users: [User]?
    var dateCreated: Date? = nil
    var lastModified: Date? = nil
    var frequency: String? = nil
    var contextType: Context? = nil
    var leaderQuestions: [Question]? = nil
    var memberQuestions: [Question]? = nil

    enum TopicKeys: String, CodingKey {
        case topicId
        case userId
        case title
        case surveys = "survey"
        case users
        case lastModified
        case frequency
        case contextType
        case leaderQuestions
        case memberQuestions
        case owner
        case surveyId
    }

    required init(from decoder: Decoder) throws {
        let topicContainer = try decoder.container(keyedBy: TopicKeys.self)
        let ownerContainer = try topicContainer.nestedContainer(keyedBy: TopicKeys.self, forKey: .owner)
        var surveyContainer = try topicContainer.nestedUnkeyedContainer(forKey: .surveys)
        let surveyIdContainer = try surveyContainer.nestedContainer(keyedBy: TopicKeys.self)

        userId = try ownerContainer.decode(Int.self, forKey: .userId)
        title = try topicContainer.decode(String.self, forKey: .title)
        topicId = try topicContainer.decode(Int.self, forKey: .topicId)
        users = try topicContainer.decode([User].self, forKey: .users)

        var surveyIds: [Int] = []

        while !surveyContainer.isAtEnd {
            let surveyID = try surveyIdContainer.decode(Int.self, forKey: .surveyId)
            surveyIds.append(surveyID)
        }

        surveys = surveyIds
    }

    init(topicId: Int?,
         userId: Int?,
         title: String,
         surveys: [Int]?,
         dateCreated: Date?,
         lastModified: Date?,
         frequency: String?,
         contextType: Context?,
         users: [User]?) {
        self.topicId = topicId
        self.userId = userId
        self.title = title
        self.surveys = surveys
        self.dateCreated = dateCreated
        self.lastModified = lastModified
        self.frequency = frequency
        self.contextType = contextType
        self.leaderQuestions = contextType!.leaderQuestions
        self.memberQuestions = contextType!.memberQuestions
        self.users = users
    }
}
