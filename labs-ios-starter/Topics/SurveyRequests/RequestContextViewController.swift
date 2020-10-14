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

    var defaultSurvey: Survey?
    var leaderQuestions: [Question] = []
    var memberQuestions: [Question] = []

    let placeholderText = "Please answer your context question"

    override func viewDidLoad() {
        super.viewDidLoad()
        if let defaultQuestions = defaultSurvey?.questions {
            setUpQuestions(questions: defaultQuestions)
        } else {
            NSLog("Failed to get default questions")
        }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RequestMemberViewSegue" {
            
        }
    }
}

extension RequestContextViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaderQuestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestContextCell", for: indexPath) as? AnswersTableViewCell else {
            return UITableViewCell()
        }
        cell.question = leaderQuestions[indexPath.row]
        cell.answerTextView.delegate = self
        cell.answerTextView.text = placeholderText
        cell.answerTextView.textColor = UIColor.placeholderText
        return cell
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
        }
    }
}
