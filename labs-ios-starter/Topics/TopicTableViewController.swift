//
//  TopicTableViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 09/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class TopicTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var topics: [Topic] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        UserController.shared.fetchTopics { topics in
            if let topics = topics {
                self.topics = topics.results
            }
        }
    }
}

extension TopicTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath)
        let topic = topics[indexPath.row].title
        cell.textLabel?.text = topic
        return cell
    }
}
