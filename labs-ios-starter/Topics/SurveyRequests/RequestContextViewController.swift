//
//  RequestContextViewController.swift
//  labs-ios-starter
//
//  Created by Hunter Oppel on 10/12/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class RequestContextViewController: ShiftableViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var addNewQuestionButton: UIButton!
    @IBOutlet var submitContextQuestionButton: UIButton!

    var defaultSurvey: Survey?
    var topicId: Int?
    var leaderQuestions: [Question] = []
    var memberQuestions: [Question] = []

    var indexToEdit: Int?
    let placeholderText = "Please fill in empty field"
    var delegate: SurveyRequestDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let defaultQuestions = defaultSurvey?.questions {
            setUpQuestions(questions: defaultQuestions)
        } else {
            NSLog("Failed to get default questions")
        }
        setUpView()
    }

    private func setUpView() {
        addNewQuestionButton.layer.borderWidth = 1
        addNewQuestionButton.layer.cornerRadius = 5
        submitContextQuestionButton.layer.borderWidth = 1
        submitContextQuestionButton.layer.cornerRadius = 5
    }

    private func setUpQuestions(questions: [Question]) {
        for question in questions {
            if question.leader ?? false {
                leaderQuestions.append(question)
            } else {
                memberQuestions.append(question)
            }
        }
        tableView.reloadData()
    }

    private func updateLeaderQuestions() {
        var cells = [AnswerContextTableViewCell]()
        for cellNumber in 0...tableView.numberOfRows(inSection: 0) {
            if let cell = tableView.cellForRow(at: IndexPath(row: cellNumber, section: 0)) as? AnswerContextTableViewCell {
                cells.append(cell)
            }
        }

        var answeredLeaderQuestions: [Question] = []
        for cell in cells {
            guard let leaderQuestionText = cell.questionTextView.text,
                let leaderAnswerText = cell.answerTextView.text else { return }
            let leaderAnswer = Answer(body: leaderAnswerText)
            let response = Question(body: leaderQuestionText, type: "TEXT", leader: false, answers: [leaderAnswer])
            answeredLeaderQuestions.append(response)
        }
        leaderQuestions = answeredLeaderQuestions
    }

    @IBAction func submitContextQuestionsButtonTapped(_ sender: Any) {
        updateLeaderQuestions()
        performSegue(withIdentifier: "RequestMemberViewSegue", sender: self)
    }

    @IBAction func addNewQuestionButtonTapped(_ sender: Any) {
        updateLeaderQuestions()
        let newQuestion = Question(body: placeholderText, type: "TEXT", leader: true)
        leaderQuestions.append(newQuestion)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RequestMemberViewSegue" {
            guard let destinationVC = segue.destination as? RequestMemberViewController else { return }
            destinationVC.leaderQuestions = leaderQuestions
            destinationVC.memberQuestions = memberQuestions
            destinationVC.topicId = topicId
            destinationVC.delegate = delegate
        }
    }
}

extension RequestContextViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaderQuestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestContextCell", for: indexPath) as? AnswerContextTableViewCell else {
            return UITableViewCell()
        }
        cell.questionTextView.text = leaderQuestions[indexPath.row].body
        if let answerText = leaderQuestions[indexPath.row].answers?.first?.body {
            cell.answerTextView.text = answerText
        } else {
            cell.answerTextView.text = placeholderText
            cell.answerTextView.textColor = .placeholderText
        }

        cell.questionTextView.delegate = self
        cell.answerTextView.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            leaderQuestions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RequestContextViewController {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholderText
            textView.textColor = UIColor.placeholderText
        } else {
            updateLeaderQuestions()
        }
    }
}
