//
//  MockDataLoader.swift
//  NetworkingTests
//
//  Created by Tobi Kuyoro on 06/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation
@testable import labs_ios_starter

class MockDataLoader: NetworkDataLoader {

    let data: Data?
    let response: URLResponse?
    let error: Error?

    internal init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    convenience init(data: Data?) {
        self.init(data: data, response: nil, error: nil)
    }

    func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            completion(self.data, self.response, self.error)
        }
    }
}
