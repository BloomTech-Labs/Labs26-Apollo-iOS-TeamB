//
//  ContextResults.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 29/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class ContextResults: Decodable {
    let results: [Context]

    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        var results: [Context] = []

        while !container.isAtEnd {
            let context = try container.decode(Context.self)
            results.append(context)
        }

        self.results = results
    }

}
