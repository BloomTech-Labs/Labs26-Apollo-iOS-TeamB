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
        updateMemberQuestions()
        let newQuestion = Question(body: "", type: "TEXT", leader: false)
        memberQuestions.append(newQuestion)
        tableView.reloadData()
    }

    private func updateMemberQuestions() {
        var cells = [QuestionsTableViewCell]()
        for cellNumber in 0...tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: cellNumber, section: 0)) as? QuestionsTableViewCell {
                cells.append(cell)
            }
        }

        var newMemberQuestions: [Question] = []
        for cell in cells {
            guard let memberQuestionText = cell.questionBodyTextView.text else { return }
            let response = Question(body: memberQuestionText, type: "TEXT", leader: false)
            newMemberQuestions.append(response)
        }
        memberQuestions = newMemberQuestions
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateMemberQuestions()
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "TopicCodeSegue" {
              if let destionationVC = segue.destination as? TopicCodeViewController {
                  updateMemberQuestions()
                  newTopic?.defaultSurvey?.questions?.append(contentsOf: memberQuestions)
                  destionationVC.newTopic = newTopic
              }
          }
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
