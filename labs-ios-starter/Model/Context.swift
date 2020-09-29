//
//  Context.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class Context: Decodable {
    let description: String
    let survey: Survey
    let contextId: Int

    init(description: String, survey: Survey, contextId: Int) {
        self.description = description
        self.survey = survey
        self.contextId = contextId
    }
}
