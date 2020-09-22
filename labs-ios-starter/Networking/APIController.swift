
//
//  APIController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 22/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

class APIContoller {

    private let baseURL = URL(string: "http://apollo-b-api.herokuapp.com")!

    func fetchTopics(completion: @escaping (TopicResults?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("topics").appendingPathComponent("topics")
        let request = URLRequest(url: requestURL)

        URLSession.shared.dataTask(with: request) { data, _, error in
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
        }.resume()
    }

    func fetchUsers(completion: @escaping (UserResults?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("users").appendingPathComponent("users")
        let request = URLRequest(url: requestURL)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error fetching users: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                NSLog("No user data for users request")
                completion(nil)
                return
            }

            do {
                let users = try JSONDecoder().decode(UserResults.self, from: data)
                DispatchQueue.main.async { completion(users) }
            } catch {
                NSLog("Error decoding users data: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
