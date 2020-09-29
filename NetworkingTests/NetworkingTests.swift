//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Tobi Kuyoro on 29/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import XCTest
import OktaAuth
@testable import labs_ios_starter

class NetworkingTests: XCTestCase {

    func testFetchinTopics() {
        let expectation = XCTestExpectation(description: "Waiting for topics data")
        let userController = UserController()

        userController.fetchTopics { topics in
            guard let topics = topics else {
                XCTFail("Error getting topics from database")
                return
            }

            XCTAssertNotNil(topics.results)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
