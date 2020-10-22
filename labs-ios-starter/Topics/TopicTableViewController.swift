//
//  TopicTableViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 09/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class TopicTableViewController: ShiftableViewController {

    @IBOutlet weak var tableView: UITableView!

    var topics: [Topic] = []
    let userid = UserDefaults.standard.integer(forKey: "User")
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
                    self.unableToFetchTopicsAlert()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }

    private func topicError(failedTo error: String) {
        DispatchQueue.main.async {
            if error == "delete" {
                self.unableToDeleteTopicAlert()
            } else if error == "leave" {
                self.unableToLeaveTopicAlert()
            }
        }
    }

    private func deleteTopic(with topicId: Int) {
        UserController.shared.deleteTopic(with: topicId) { error in
            if error != nil {
                self.topicError(failedTo: "delete")
            } else {
                self.refreshTableView()
            }
        }
    }

    private func leaveTopic(with topicId: Int) {
        UserController.shared.leaveTopic(with: topicId) { error in
            if error != nil {
                self.topicError(failedTo: "leave")
            } else {
                self.refreshTableView()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTopicDetailSegue" {
            if let destionationVC = segue.destination as? SurveyViewController,
                let indexPath = tableView.indexPathForSelectedRow,
                let surveys = topics[indexPath.row].surveys {
                destionationVC.topicTitle = topics[indexPath.row].title
                destionationVC.surveys = surveys
                destionationVC.defaultSurvey = topics[indexPath.row].defaultSurvey
                destionationVC.topicId = topics[indexPath.row].topicId
                destionationVC.joincode = topics[indexPath.row].joincode

                if userid == topics[indexPath.row].userid {
                    destionationVC.isLeader = true
                }
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let topic = topics[indexPath.row]
        guard let topicId = topic.topicId else { return }

        if editingStyle == .delete {
            if userid == topic.userid {
                self.deleteTopic(with: topicId)
            } else {
                self.leaveTopic(with: topicId)
            }
        }
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let topic = topics[indexPath.row]
        let title = userid == topic.userid ? "Delete" : "Leave"
        return title
    }
}
