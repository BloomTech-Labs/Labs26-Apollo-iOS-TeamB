
//
//  APIController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 22/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation
import OktaAuth

extension UserController {

    func fetchTopics(isMock: Bool = false, completion: @escaping (TopicResults?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("topics").appendingPathComponent("topics")
        var request = URLRequest(url: requestURL)

        if !isMock {
            guard let oktaCredentials = getOktaAuth() else { return }
            request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")
        }

        dataLoader.loadData(using: request) { data, response, error in
            if let error = error {
                    NSLog("Error fetching topics: \(error)")
                    completion(nil)
                    return
                }

                guard let data = data else {
                    NSLog("No topic data for topics request")
                    completion(nil)
                    return
                }

                do {
                    let topics = try JSONDecoder().decode(TopicResults.self, from: data)
                    DispatchQueue.main.async { completion(topics) }
                } catch {
                    NSLog("Error decoding topics data: \(error)")
                    completion(nil)
                }
            }
    }

    func fetchSurveys(isMock: Bool = false, completion: @escaping (SurveyResults?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("surveys").appendingPathComponent("all")
        var request = URLRequest(url: requestURL)

        if !isMock {
            guard let oktaCredentials = getOktaAuth() else { return }
            request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")
        }

        dataLoader.loadData(using: request) { data, _, error in
            if let error = error {
                NSLog("Error fetching surveys: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                NSLog("No survey data for surveys request")
                completion(nil)
                return
            }

            do {
                let surveys = try JSONDecoder().decode(SurveyResults.self, from: data)
                DispatchQueue.main.async { completion(surveys) }
            } catch {
                NSLog("Error decoding surveys data: \(error)")
                completion(nil)
            }
        }
    }

    func fetchQuestions(isMock: Bool = false, completion: @escaping (QuestionResults?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("questions").appendingPathComponent("all")
        var request = URLRequest(url: requestURL)

        if !isMock {
            guard let oktaCredentials = getOktaAuth() else { return }
            request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")
        }

        dataLoader.loadData(using: request) { data, _, error in
            if let error = error {
                NSLog("Error fetching questions: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                NSLog("No question data for questions request")
                completion(nil)
                return
            }

            do {
                let questions = try JSONDecoder().decode(QuestionResults.self, from: data)
                DispatchQueue.main.async { completion(questions) }
            } catch {
                NSLog("Error decoding questions data: \(error)")
                completion(nil)
            }
        }
    }

    func fetchContexts(isMock: Bool = false, completion: @escaping (ContextResults?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("contexts").appendingPathComponent("contexts")
        var request = URLRequest(url: requestURL)

        if !isMock {
            guard let oktaCredentials = getOktaAuth() else { return }
            request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")
        }

        dataLoader.loadData(using: request) { data, _, error in
            if let error = error {
                NSLog("Error fetching contexts: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                NSLog("No context data")
                completion(nil)
                return
            }

            do {
                let contexts = try JSONDecoder().decode(ContextResults.self, from: data)
                DispatchQueue.main.async { completion(contexts) }
            } catch {
                NSLog("Error decoding contexts data: \(error)")
                completion(nil)
            }
        }
    }

    func createTopic(_ topic: Topic, completion: @escaping (Topic?) -> Void) {
        guard let oktaCredentials = getOktaAuth() else { return }

        let requestURL = baseURL.appendingPathComponent("topics").appendingPathComponent("new")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let newTopic = try JSONEncoder().encode(topic)
            request.httpBody = newTopic
        } catch {
            NSLog("Error encoding topic: \(error)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error creating new topic: \(error)")
                completion(nil)
                return
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                NSLog("Received \(response.statusCode) code while creating a new topic")
                completion(nil)
                return
            }

            guard let data = data else {
                print("Data returned was nil")
                completion(nil)
                return
            }

            do {
                let topic = try JSONDecoder().decode(Topic.self, from: data)
                DispatchQueue.main.async {
                    completion(topic)
                }
            } catch {
                NSLog("Error decoding contexts data: \(error)")
                completion(nil)
            }
        }.resume()
    }

    func answerSurveyRequest(for questions: [Question], completion: @escaping (Error?) -> Void) {
        guard let oktaCredentials = getOktaAuth() else { return }

        let requestURL = baseURL.appendingPathComponent("surveys").appendingPathComponent("response")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let memberQuestions = try JSONEncoder().encode(questions)
            request.httpBody = memberQuestions
        } catch {
            NSLog("Error answering survey request: \(error)")
            completion(error)
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Error posting request: \(error)")
                completion(error)
                return
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                NSLog("Received \(response.statusCode) code while answering survey request")
                completion(nil)
                return
            }
            completion(nil)
        }.resume()
    }

    func fetchLeaderQuestions(using surveyId: Int, completion: @escaping (QuestionResults?) -> Void) {
        guard let oktaCredentials = getOktaAuth() else { return }

        let requestURL = baseURL
            .appendingPathComponent("questions")
            .appendingPathComponent("leader")
            .appendingPathComponent(surveyId.description)

        var request = URLRequest(url: requestURL)
        request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error fetching questions: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                NSLog("No question data")
                completion(nil)
                return
            }

            do {
                let questions = try JSONDecoder().decode(QuestionResults.self, from: data)
                DispatchQueue.main.async {
                    completion(questions)
                }
            } catch {
                NSLog("Error decoding question data: \(error)")
                completion(nil)
            }
        }.resume()
    }

    func fetchSpecificSurvey(with surveyId: Int, completion: @escaping (Survey?) -> Void) {
        guard let oktaCredentials = getOktaAuth() else { return }

        let requestURL = baseURL
            .appendingPathComponent("surveys")
            .appendingPathComponent("survey")
            .appendingPathComponent(surveyId.description)

        var request = URLRequest(url: requestURL)
        request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error fetching survey with \(surveyId.description): \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                NSLog("No survey data")
                completion(nil)
                return
            }

            do {
                let survey = try JSONDecoder().decode(Survey.self, from: data)
                DispatchQueue.main.async {
                    completion(survey)
                }
            } catch {
                NSLog("Error decoding survey data: \(error)")
                completion(nil)
            }
        }.resume()
    }

    func joinTopic(_ joincode: String, completion: @escaping (Bool) -> Void) {
        guard let oktaCredentials = getOktaAuth() else { return }

        let requestURL = baseURL.appendingPathComponent("topics").appendingPathComponent("topic").appendingPathComponent(joincode)
        var request = URLRequest(url: requestURL)

        request.httpMethod = "POST"
        request.addValue("Bearer \(oktaCredentials.accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error creating new topic: \(error)")
                completion(false)
                return
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                NSLog("Received \(response.statusCode) code while trying to join topic")
                completion(false)
                return
            }

            DispatchQueue.main.async {
                completion(true)
            }
        }.resume()
    }

    private func getOktaAuth() -> OktaCredentials? {
        let oktaCredentials: OktaCredentials

        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            print("AUTH FAIL: \(error)")
            return nil
        }

        return oktaCredentials
    }
}
