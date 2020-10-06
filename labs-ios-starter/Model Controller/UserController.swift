//
//  UserController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/23/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit
import OktaAuth

class UserController {

    let baseURL = URL(string: "https://apollo-b-api.herokuapp.com")!
    let oktaBaseURL = URL(string: "https://labs-api-starter.herokuapp.com/")!
    
    static let shared = UserController()
    
    let oktaAuth = OktaAuth(baseURL: URL(string: "https://auth.lambdalabs.dev/")!,
                            clientID: "0oalwkxvqtKeHBmLI4x6",
                            redirectURI: "labs://scaffolding/implicit/callback")
    
    private(set) var authenticatedUserUser: OktaProfile?
    private(set) var users: [OktaProfile] = []

    let dataLoader: NetworkDataLoader
    
    init(dataLoader: NetworkDataLoader = URLSession.shared) {
        self.dataLoader = dataLoader
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshUsers),
                                               name: .oktaAuthenticationSuccessful,
                                               object: nil)
    }
    
    @objc func refreshUsers() {
        getAllUsers()
    }
    
    func getAllUsers(completion: @escaping () -> Void = {}) {
        
        var oktaCredentials: OktaCredentials
        
        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            postAuthenticationExpiredNotification()
            NSLog("Credentials do not exist. Unable to get users from API")
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        
        let requestURL = oktaBaseURL.appendingPathComponent("profiles")
        var request = URLRequest(url: requestURL)
        
        request.addValue("Bearer \(oktaCredentials.idToken)", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            
            if let error = error {
                NSLog("Error getting all users: \(error)")
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Returned status code is not the expected 200. Instead it is \(response.statusCode)")
            }
            
            guard let data = data else {
                NSLog("No data returned from getting all users")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let users = try decoder.decode([OktaProfile].self, from: data)
                
                DispatchQueue.main.async {
                    self.users = users
                }
            } catch {
                NSLog("Unable to decode [User] from data: \(error)")
            }
        }
        
        dataTask.resume()
    }
    
    func getAuthenticatedUserUser(completion: @escaping () -> Void = { }) {
        var oktaCredentials: OktaCredentials
        
        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            postAuthenticationExpiredNotification()
            NSLog("Credentials do not exist. Unable to get authenticated user user from API")
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        
        guard let userID = oktaCredentials.userID else {
            NSLog("User ID is missing.")
            DispatchQueue.main.async {
                completion()
            }
            return
        }
        
        getSingleUser(userID) { (user) in
            self.authenticatedUserUser = user
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func checkForExistingAuthenticatedUserUser(completion: @escaping (Bool) -> Void) {
        getAuthenticatedUserUser {
            completion(self.authenticatedUserUser != nil)
        }
    }
    
    func getSingleUser(_ userID: String, completion: @escaping (OktaProfile?) -> Void) {
        
        var oktaCredentials: OktaCredentials
        
        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            postAuthenticationExpiredNotification()
            NSLog("Credentials do not exist. Unable to get user from API")
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        let requestURL = oktaBaseURL
            .appendingPathComponent("profiles")
            .appendingPathComponent(userID)
        var request = URLRequest(url: requestURL)
        
        request.addValue("Bearer \(oktaCredentials.idToken)", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var fetchedUser: OktaProfile?
            
            defer {
                DispatchQueue.main.async {
                    completion(fetchedUser)
                }
            }
            
            if let error = error {
                NSLog("Error getting all users: \(error)")
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Returned status code is not the expected 200. Instead it is \(response.statusCode)")
            }
            
            guard let data = data else {
                NSLog("No data returned from getting all users")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let user = try decoder.decode(OktaProfile.self, from: data)
                fetchedUser = user
            } catch {
                NSLog("Unable to decode User from data: \(error)")
            }
        }
        
        dataTask.resume()
    }
    
    func updateAuthenticatedUserUser(_ user: OktaProfile, with name: String, email: String, avatarURL: URL, completion: @escaping (OktaProfile) -> Void) {
        
        var oktaCredentials: OktaCredentials
        
        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            postAuthenticationExpiredNotification()
            NSLog("Credentials do not exist. Unable to get authenticated user user from API")
            DispatchQueue.main.async {
                completion(user)
            }
            return
        }
        
        let requestURL = oktaBaseURL
            .appendingPathComponent("profiles")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(oktaCredentials.idToken)", forHTTPHeaderField: "Authorization")
        
//        do {
//            request.httpBody = try JSONEncoder().encode(user)
//        } catch {
//            NSLog("Error encoding user JSON: \(error)")
//            DispatchQueue.main.async {
//                completion(user)
//            }
//            return
//        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            var user = user
            
            defer {
                DispatchQueue.main.async {
                    completion(user)
                }
            }
            
            if let error = error {
                NSLog("Error adding user: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Returned status code is not the expected 200. Instead it is \(response.statusCode)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from updating user")
                return
            }
            
//            do {
//                user = try JSONDecoder().decode(UserWithMessage.self, from: data).user
//                self.authenticatedUserUser = user
//            } catch {
//                NSLog("Error decoding `UserWithMessage`: \(error)")
//            }
        }
        
        dataTask.resume()
    }
    
    // NOTE: This method is unused, but left as an example for creating a user.
    
//    func createUser(with email: String, name: String, avatarURL: URL) {
//        var oktaCredentials: OktaCredentials
//        
//        do {
//            oktaCredentials = try oktaAuth.credentialsIfAvailable()
//        } catch {
//            postAuthenticationExpiredNotification()
//            NSLog("Credentials do not exist. Unable to create a user for the authenticated user")
//        }
//        
//        guard let userID = oktaCredentials.userID else {
//            NSLog("Credentials do not exist. Unable to create user")
//        }
//    }
    
    // NOTE: This method is unused, but left as an example for creating a user on the scaffolding backend.
    
    func addUser(_ user: OktaProfile, completion: @escaping () -> Void) {
        
        var oktaCredentials: OktaCredentials
        
        do {
            oktaCredentials = try oktaAuth.credentialsIfAvailable()
        } catch {
            postAuthenticationExpiredNotification()
            NSLog("Credentials do not exist. Unable to add user to API")
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            return
        }
        
        let requestURL = oktaBaseURL.appendingPathComponent("profiles")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(oktaCredentials.idToken)", forHTTPHeaderField: "Authorization")
        
//        do {
//            request.httpBody = try JSONEncoder().encode(user)
//        } catch {
//            NSLog("Error encoding user: \(user)")
//            defer {
//                DispatchQueue.main.async {
//                    completion()
//                }
//            }
//            return
//        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            
            if let error = error {
                NSLog("Error adding user: \(error)")
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Returned status code is not the expected 200. Instead it is \(response.statusCode)")
                return
            }
            
            self.users.append(user)
        }
        dataTask.resume()
    }
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            var fetchedImage: UIImage? = nil
            
            defer {
                DispatchQueue.main.async {
                    completion(fetchedImage)
                }
            }
            if let error = error {
                NSLog("Error fetching image for url: \(url.absoluteString), error: \(error)")
                return
            }
            
            guard let data = data,
                let image = UIImage(data: data) else {
                    return
            }
            fetchedImage = image
        }
        dataTask.resume()
    }
    
    func postAuthenticationExpiredNotification() {
        NotificationCenter.default.post(name: .oktaAuthenticationExpired, object: nil)
    }
}
