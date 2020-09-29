//
//  Topic.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Topic: Decodable {
    var topicId: Int?
    var title: String?
    var userid: Int?
    var frequency: String?
    var defaultSurvey: Survey?
    var joincode: String?
    var surveys: [Survey]?
    var users: [User]?

    init(topicId: Int?,
         title: String?,
         userid: Int?,
         frequency: String?,
         defaultSurvey: Survey?,
         joincode: String?,
         surveys: [Survey]?,
         users: [User]?) {

        self.topicId = topicId
        self.title = title
        self.userid = userid
        self.frequency = frequency
        self.defaultSurvey = defaultSurvey
        self.joincode = joincode
        self.surveys = surveys
        self.users = users
    }

    enum TopicKeys: String, CodingKey {
        case topicId, title, frequency, joincode, users
        case owner, userid
        case defaultsurvey, surveysrequests
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopicKeys.self)
        let ownerContainer = try container.nestedContainer(keyedBy: TopicKeys.self, forKey: .owner)
        let defaultSurveyContainer = try container.nestedContainer(keyedBy: TopicKeys.self, forKey: .defaultsurvey)

        self.topicId = try container.decode(Int.self, forKey: .topicId)
        self.title = try container.decode(String.self, forKey: .title)
        self.userid = try ownerContainer.decode(Int.self, forKey: .userid)
        self.frequency = try container.decode(String.self, forKey: .frequency)
        self.defaultSurvey = try defaultSurveyContainer.decode(Survey.self, forKey: .defaultsurvey)
        self.joincode = try container.decode(String.self, forKey: .joincode)
        self.surveys = try container.decode([Survey].self, forKey: .surveysrequests)
        self.users = try container.decode([User].self, forKey: .users)
    }

    convenience init() {
        self.init(topicId: nil, title: nil, userid: nil, frequency: nil, defaultSurvey: nil, joincode: nil, surveys: nil, users: nil)
    }
}

extension Topic: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: TopicKeys.self)

        try container.encode(title, forKey: .title)
        try container.encode(frequency, forKey: .frequency)
        try container.encode(defaultSurvey, forKey: .defaultsurvey)
    }
}
