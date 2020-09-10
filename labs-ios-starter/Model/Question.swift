//
//  Question.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Question: Codable {
    let id: Int
    let surveyID: Int
    let body: String
    let responses: [Response]
    let dateCreated: Date
    let lastModified: Date

    init(id: Int, surveyID: Int, body: String, responses: [Response], dateCreated: Date, lastModified: Date) {
        self.id = id
        self.surveyID = surveyID
        self.body = body
        self.responses = responses
        self.dateCreated = dateCreated
        self.lastModified = lastModified
    }
}
