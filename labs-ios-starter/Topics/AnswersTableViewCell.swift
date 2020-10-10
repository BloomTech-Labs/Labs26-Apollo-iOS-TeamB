//
//  AnswersTableViewCell.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 09/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class AnswersTableViewCell: UITableViewCell {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerTextView: UITextView!

    var question: Question? {
        didSet {
            updateViews()
        }
    }

    private func updateViews() {
        guard let question = question else { return }
        questionLabel.text = question.body
        answerTextView.text = question.answers?.first?.body
//        print("Question: \(question.body)")
//        print("Answer: \(question.answers?.first?.body)")
    }
}
