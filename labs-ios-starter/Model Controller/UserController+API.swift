
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

    func fetchTopics(completion: @escaping (TopicResults?) -> Void) {
        let oktaCredentials: OktaCredentials

        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            print("AUTH FAIL: \(error)")
            return
        }

        let requestURL = baseURL.appendingPathComponent("topics").appendingPathComponent("topics")
        var request = URLRequest(url: requestURL)

        request.addValue("Bearer \(oktaCredentials.idToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Server returned request")
            if let error = error {
                NSLog("Error fetching topics: \(error)")
                completion(nil)
                return
            }

            if let response = response as? HTTPURLResponse {
                print("Response is: \(response.statusCode)")
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
        }.resume()
        print("Sent request to server")
    }

    func fetchSurveys(completion: @escaping (SurveyResults?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("surveys").appendingPathComponent("all")
        let request = URLRequest(url: requestURL)

        URLSession.shared.dataTask(with: request) { data, _, error in
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
        }.resume()
    }

    func fetchQuestions(completion: @escaping (QuestionResults?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("questions")
        let request = URLRequest(url: requestURL)

        URLSession.shared.dataTask(with: request) { data, _, error in
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
        }.resume()
    }

    func fetchContexts(completion: @escaping (ContextResults?) -> Void) {
        let oktaCredentials: OktaCredentials

        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            print("AUTH FAIL: \(error)")
            return
        }

        let requestURL = baseURL.appendingPathComponent("contexts").appendingPathComponent("contexts")
        var request = URLRequest(url: requestURL)

        request.addValue("Bearer \(oktaCredentials.idToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
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
        }.resume()
    }
}
