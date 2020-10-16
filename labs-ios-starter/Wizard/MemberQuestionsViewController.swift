//
//  MemberQuestionsViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class MemberQuestionsViewController: ShiftableViewController {

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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TopicCodeSegue" {
            if let destionationVC = segue.destination as? TopicCodeViewController {
                newTopic?.defaultSurvey?.questions?.append(contentsOf: memberQuestions)
                destionationVC.newTopic = newTopic
            }
        }
    }

    // MARK: - TextView Delegate Methods

    func textViewDidBeginEditing(_ textView: UITextView) {
        indexToEdit = memberQuestions.firstIndex(where: { question -> Bool in
            guard let questionText = textView.text else { return false }
            return question.body == questionText
        })
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard let indexToEdit = indexToEdit, let questionText = textView.text else { return }
        memberQuestions[indexToEdit].body = questionText
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
        cell.questionBodyTextView.text = memberQuestions[indexPath.row].body
        cell.questionBodyTextView.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memberQuestions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
