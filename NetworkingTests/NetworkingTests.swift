//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Tobi Kuyoro on 19/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import XCTest
@testable import labs_ios_starter

class NetworkingTests: XCTestCase {

    func testFetchingTopics() {
        let controller = UserController()
        let expectation = XCTestExpectation(description: "Waiting on topic results")
        controller.fetchTopics(isMock: true, isTest: true) { topics in
            guard let topics = topics?.results else {
                XCTFail("Failed to fetch topics")
                return
            }

            XCTAssertEqual(topics[0].title, "Standup")
            XCTAssertEqual(topics[1].topicId, 114)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testFetchingSpecificSurvey() {
        let controller = UserController()
        let expectation = XCTestExpectation(description: "Waiting for survey results")
        controller.fetchSpecificSurvey(isMock: true, isTest: true, with: 94) { survey in
            guard let survey = survey else {
                XCTFail("Failed to fetch survey with id 94")
                return
            }

            XCTAssertEqual(survey.createdDate, "2020-10-09 08:33:51")
            XCTAssertEqual(survey.topicId, 37)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
