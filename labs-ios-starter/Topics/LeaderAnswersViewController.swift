//
//  LeaderAnswersViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 09/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class LeaderAnswersViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var continueButton: UIButton!

    var surveyId: Int?
    var questions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
        tableView.separatorStyle = .none
        continueButton.layer.cornerRadius = 5
    }

    @IBAction func continueButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "MembersRespondSegue", sender: self)
    }


    private func fetchQuestions() {
        guard let surveyId = surveyId else { return }
        UserController.shared.fetchLeaderQuestions(using: surveyId) { results in
            if let results = results {
                self.questions = results.questions
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MembersRespondSegue" {
            if let destinationVC = segue.destination as? MemberAnswersViewController {
                destinationVC.surveyId = surveyId
            }
        }
    }
}

extension LeaderAnswersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnswersCell", for: indexPath) as? AnswersTableViewCell else { return UITableViewCell() }

        cell.question = questions[indexPath.row]
        return cell
    }
}
