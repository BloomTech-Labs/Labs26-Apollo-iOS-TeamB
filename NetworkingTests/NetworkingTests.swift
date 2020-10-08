//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Tobi Kuyoro on 29/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import XCTest
@testable import labs_ios_starter

class NetworkingTests: XCTestCase {

    func testFetchinTopics() {
        let dataLoader = MockDataLoader(data: topics)
        let expectation = XCTestExpectation(description: "Waiting for topic results")
        let controller = UserController(dataLoader: dataLoader)

        controller.fetchTopics(isMock: true) { topics in
            guard let topics = topics else {
                XCTFail("Failed to get results from mock data")
                return
            }

            XCTAssertEqual(topics.results.count, 1, "There should only be one valid topic")
            XCTAssertTrue(topics.results[0].topicId == 37, "The topic ID should be 37")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    func testFetchingSurveys() {
        let dataLoader = MockDataLoader(data: surveys)
        let expectation = XCTestExpectation(description: "Waiting for survey results")
        let controller = UserController(dataLoader: dataLoader)


        controller.fetchSurveys(isMock: true) { results in
            guard let results = results else {
                XCTFail("Failed to get surveys from mock data")
                return
            }

            XCTAssertLessThanOrEqual(results.surveys.count, 3)
            XCTAssertEqual(results.surveys[0].questions?.count, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    func testFetchingQuestions() {
        let dataLoader = MockDataLoader(data: questions)
        let expectation = XCTestExpectation(description: "Waiting for question results")
        let controller = UserController(dataLoader: dataLoader)


        controller.fetchQuestions(isMock: true) { results in
            guard let results = results else {
                XCTFail("Failed to get surveys from mock data")
                return
            }

            XCTAssertEqual(results.questions[0].questionId, 56)
            XCTAssertTrue(results.questions[1].body == "Leader Question 2")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    func testFetchingContexts() {
        let dataLoader = MockDataLoader(data: contexts)
        let expectation = XCTestExpectation(description: "Waiting for context results")
        let controller = UserController(dataLoader: dataLoader)


        controller.fetchContexts(isMock: true) { contexts in
            guard let contexts = contexts else {
                XCTFail("Failed to get surveys from mock data")
                return
            }

            XCTAssertEqual(contexts.results.count, 4)
            XCTAssertEqual(contexts.results[1].description, "delivery management")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }
}
