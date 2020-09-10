//
//  Comment.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Comment: Codable {
    let id: Int
    let userID: Int
    let body: String
    let dateCreated: Date

    init(id: Int, userID: Int, body: String, dateCreated: Date) {
        self.id = id
        self.userID = userID
        self.body = body
        self.dateCreated = dateCreated
    }
}
