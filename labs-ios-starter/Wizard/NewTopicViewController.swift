//
//  NewTopicViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class NewTopicViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var contexts: [Context] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        print("NEW TOPIC")

        UserController.shared.fetchContexts { contexts in
            if let contexts = contexts {
                self.contexts = contexts.results

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension NewTopicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contexts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewTopicCell", for: indexPath)
        cell.textLabel?.text = contexts[indexPath.row].description.capitalized
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
