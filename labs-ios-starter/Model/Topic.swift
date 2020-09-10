//
//  Topic.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Topic: Codable {
    let id: Int?
    let ownerID: Int?
    let title: String
    let surveys: [Int]?
    let dateCreated: Date?
    let lastModified: Date?
    let frequency: String
    let contextType: Context
    let leaderQuestions: [Question]
    let memberQuestions: [Question]

    init(id: Int?,
         ownerID: Int?,
         title: String,
         surveys: [Int]?,
         dateCreated: Date?,
         lastModified: Date?,
         frequency: String,
         contextType: Context) {
        self.id = id
        self.ownerID = ownerID
        self.title = title
        self.surveys = surveys
        self.dateCreated = dateCreated
        self.lastModified = lastModified
        self.frequency = frequency
        self.contextType = contextType
        self.leaderQuestions = contextType.leaderQuestions
        self.memberQuestions = contextType.memberQuestions
    }
}
