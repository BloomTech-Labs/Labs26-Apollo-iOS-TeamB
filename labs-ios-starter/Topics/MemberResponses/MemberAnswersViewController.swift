//
//  MemberAnswersViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 12/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class MemberAnswersViewController: ShiftableViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var respondButton: UIButton!
    
    var surveyId: Int?
    var questions: [Question] = []
    var responses: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
        tableView.separatorStyle = .none
        respondButton.layer.cornerRadius = 5
    }

    @IBAction func responseButtonTapped(_ sender: Any) {
        getResponses()
        UserController.shared.answerSurveyRequest(for: responses) { error in
            if let error = error {
                NSLog("Error posting responses: \(error)")
            }

            DispatchQueue.main.async {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: SurveyViewController.self) {
                        self.navigationController?.popToViewController(controller, animated: true)
                    }
                }
            }
        }
    }

    private func getResponses() {
        var cells = [MemberAnswersTableViewCell]()
        for cellNumber in 0...tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: cellNumber, section: 0)) as? MemberAnswersTableViewCell {
                cells.append(cell)
            }
        }

        for cell in cells {
            guard
                let question = cell.question,
                let questionId = question.questionid,
                !cell.answerTextView.text.isEmpty,
                let body = cell.answerTextView.text else { return }
            let response = Question(questionId: questionId, body: body)
            responses.append(response)
        }
    }

    private func fetchQuestions() {
        guard let surveyId = surveyId else { return }
        UserController.shared.fetchSpecificSurvey(with: surveyId) { results in
            if let results = results,
                let questions = results.questions {
                for question in questions {
                    if question.leader == false {
                        self.questions.append(question)
                    }
                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension MemberAnswersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MembersCell", for: indexPath) as? MemberAnswersTableViewCell else { return UITableViewCell() }

        cell.question = questions[indexPath.row]
        cell.answerTextView.delegate = self
        return cell
    }
}
