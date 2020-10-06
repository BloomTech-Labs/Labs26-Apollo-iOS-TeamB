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
    private let refreshControl = UIRefreshControl()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        refreshTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRefreshControl()
    }

    private func setUpRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }

        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }

    @objc private func refreshTableView() {
        UserController.shared.fetchTopics { topics in
            if let topics = topics {
                self.topics = topics.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            } else {
                DispatchQueue.main.async {
                    self.presentSimpleAlert(with: "ERROR", message: "Failed to get topics from server. Please try again later.", preferredStyle: .alert, dismissText: "OK")
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTopicDetailSegue" {
            if let destionationVC = segue.destination as? SurveyViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                guard let surveys = topics[indexPath.row].surveys else { return }
                destionationVC.surveys = surveys
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
