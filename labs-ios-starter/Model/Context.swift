//
//  Context.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Context: Codable {
    let id: Int
    let name: String
    let leaderQuestions: [Question]
    let memberQuestions: [Question]


    init(id: Int, name: String, leaderQuestions: [Question], memberQuestions: [Question]) {
        self.id = id
        self.name = name
        self.leaderQuestions = leaderQuestions
        self.memberQuestions = memberQuestions
    }
}
