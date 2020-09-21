//
//  Survey.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Survey: Codable {
    let id: Int
    let ownerID: Int
    let dateCreated: Date
    let lastModified: Date

    init(id: Int, ownerID: Int, dateCreated: Date, lastModified: Date) {
        self.id = id
        self.ownerID = ownerID
        self.dateCreated = dateCreated
        self.lastModified = lastModified
    }
}
