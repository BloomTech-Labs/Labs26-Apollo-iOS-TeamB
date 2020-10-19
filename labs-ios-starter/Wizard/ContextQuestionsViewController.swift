//
//  ContextQuestionsViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class ContextQuestionsViewController: ShiftableViewController {

    @IBOutlet var tableView: UITableView!

    var newTopic: Topic?
    var selectedContext: Context?
    private var leaderQuestions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedContext = selectedContext {
            title = "\(selectedContext.description.split(separator: " ")[0].capitalized) Topic"

            guard let questions = selectedContext.survey.questions else { return }

            for question in questions {
                if question.leader ?? false {
                    leaderQuestions.append(question)
                }
            }

            tableView.reloadData()
        }
    }

    @IBAction func addNewQuestionTapped(_ sender: Any) {
        updateLeaderQuestions()
        let newQuestion = Question(body: "", type: "TEXT", leader: true)
        leaderQuestions.append(newQuestion)
        tableView.reloadData()
    }

    private func updateLeaderQuestions() {
        var cells = [QuestionsTableViewCell]()
        for cellNumber in 0...tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: cellNumber, section: 0)) as? QuestionsTableViewCell {
                cells.append(cell)
            }
        }

        var newLeaderQuestions: [Question] = []
        for cell in cells {
            guard let leaderQuestionText = cell.questionBodyTextField.text else { return }
            let response = Question(body: leaderQuestionText, type: "TEXT", leader: true)
            newLeaderQuestions.append(response)
        }
        leaderQuestions = newLeaderQuestions
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemberQuestionsSegue" {
            if let destinationVC = segue.destination as? MemberQuestionsViewController {
                let survey = Survey()
                updateLeaderQuestions()
                survey.questions = leaderQuestions
                newTopic?.defaultSurvey = survey
                destinationVC.newTopic = newTopic
                destinationVC.selectedContext = selectedContext
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLeaderQuestions()
    }
}

extension ContextQuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderQuestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContextQuestionCell", for: indexPath) as? QuestionsTableViewCell else {
            return UITableViewCell()
        }
        cell.questionNumberLabel.text = "Question \(indexPath.row + 1)"
        cell.questionBodyTextField.text = leaderQuestions[indexPath.row].body
        cell.questionBodyTextField.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
