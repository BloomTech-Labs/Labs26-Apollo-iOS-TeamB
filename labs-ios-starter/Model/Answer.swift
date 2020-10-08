//
//  Answer.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Answer: Codable {
    let id: Int
    let body: String
    let comments: [Comment]
    let dateCreated: Date
    let lastModified: Date

    init(id: Int, body: String, comments: [Comment], dateCreated: Date, lastModified: Date) {
        self.id = id
        self.body = body
        self.comments = comments
        self.dateCreated = dateCreated
        self.lastModified = lastModified
    }
}
