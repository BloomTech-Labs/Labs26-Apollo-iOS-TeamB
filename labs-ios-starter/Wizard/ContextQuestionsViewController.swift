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

    private var indexToEdit: Int?

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
        let newQuestion = Question(body: "", type: "TEXT", leader: true)
        leaderQuestions.append(newQuestion)
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemberQuestionsSegue" {
            if let destinationVC = segue.destination as? MemberQuestionsViewController {
                let survey = Survey()
                survey.questions = leaderQuestions
                newTopic?.defaultSurvey = survey
                destinationVC.newTopic = newTopic
                destinationVC.selectedContext = selectedContext
            }
        }
    }

    // MARK: - TextField Delegate Methods

    override func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldBeingEdited = textField
        indexToEdit = leaderQuestions.firstIndex(where: { question -> Bool in
            guard let questionText = textField.text else { return false }
            return question.body == questionText
        })
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let indexToEdit = indexToEdit, let questionText = textField.text else { return }
        leaderQuestions[indexToEdit].body = questionText
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

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            leaderQuestions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
