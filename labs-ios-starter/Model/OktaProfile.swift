//
//  OktaProfile.swift
//  labs-ios-starter
//
//  Created by Hunter Oppel on 10/1/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class OktaProfile: Decodable {
    let id: String
    var email: String?
    var name: String?

    init(id: String, email: String?, name: String?) {
        self.id = id
        self.email = email
        self.name = name
    }
}
