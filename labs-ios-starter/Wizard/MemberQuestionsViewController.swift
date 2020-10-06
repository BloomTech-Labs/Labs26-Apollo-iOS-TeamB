//
//  MemberQuestionsViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class MemberQuestionsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var newTopic: Topic?
    var selectedContext: Context?
    var memberQuestions: [Question] = []
    var indexToEdit: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        appendQuestions()
    }

    func appendQuestions() {
        if let selectedContext = selectedContext {
            title = "\(selectedContext.description.split(separator: " ")[0].capitalized) Topic"

            guard let questions = selectedContext.survey.questions else { return }

            for question in questions {
                if question.leader == false {
                    memberQuestions.append(question)
                }
            }

            tableView.reloadData()
        }
    }

    @IBAction func addNewQuestionTapped(_ sender: Any) {
        let newQuestion = Question(body: "", type: "TEXT", leader: false)
        memberQuestions.append(newQuestion)
        tableView.reloadData()
    }
}

extension MemberQuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberQuestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemberQuestionCell", for: indexPath) as? QuestionsTableViewCell else {
            return UITableViewCell()
        }
        cell.questionNumberLabel.text = "Question \(indexPath.row + 1)"
        cell.questionBodyTextField.text = memberQuestions[indexPath.row].body
        cell.questionBodyTextField.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TopicCodeSegue" {
            if let destionationVC = segue.destination as? TopicCodeViewController {
                newTopic?.defaultSurvey?.questions?.append(contentsOf: memberQuestions)
                destionationVC.newTopic = newTopic
            }
        }
    }
}

extension MemberQuestionsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        indexToEdit = memberQuestions.firstIndex(where: { question -> Bool in
            guard let questionText = textField.text else { return false }
            return question.body == questionText
        })
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let indexToEdit = indexToEdit, let questionText = textField.text else { return }
        memberQuestions[indexToEdit].body = questionText
    }
}
