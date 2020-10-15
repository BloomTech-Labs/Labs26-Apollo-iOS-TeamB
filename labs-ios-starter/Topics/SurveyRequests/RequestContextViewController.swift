//
//  RequestContextViewController.swift
//  labs-ios-starter
//
//  Created by Hunter Oppel on 10/12/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class RequestContextViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var addNewQuestionButton: UIButton!
    @IBOutlet var submitContextQuestionButton: UIButton!

    var defaultSurvey: Survey?
    var topicId: Int?
    var leaderQuestions: [Question] = []
    var memberQuestions: [Question] = []

    var indexToEdit: Int?
    let placeholderText = "Please answer your context question"
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
        guard let cells = tableView.visibleCells as? [AnswerContextTableViewCell] else { return }
        var answeredLeaderQuestions: [Question] = []
        for cell in cells {
            guard let body = cell.questionTextField.text,
                  let answerText = cell.answerTextView.text else { return }
            let answer = Answer(body: answerText)
            let newQuestion = Question(body: body, type: "TEXT", leader: true, answers: [answer])
            answeredLeaderQuestions.append(newQuestion)
        }
        leaderQuestions = answeredLeaderQuestions
    }

    @IBAction func submitContextQuestionsButtonTapped(_ sender: Any) {
        updateLeaderQuestions()
        performSegue(withIdentifier: "RequestMemberViewSegue", sender: self)
    }

    @IBAction func addNewQuestionButtonTapped(_ sender: Any) {
        updateLeaderQuestions()
        let newQuestion = Question(body: "", type: "TEXT", leader: true)
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
        cell.questionTextField.text = leaderQuestions[indexPath.row].body
        cell.answerTextView.text = leaderQuestions[indexPath.row].answers?.first?.body

        cell.questionTextField.borderStyle = .none
        cell.answerTextView.delegate = self
        cell.answerTextView.text = placeholderText
        cell.answerTextView.textColor = UIColor.placeholderText
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

extension RequestContextViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
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
