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
        questionLabel.text = "   \(question.body ?? "")"
        questionLabel.layer.cornerRadius = 5
        questionLabel.layer.borderWidth = 1
        questionLabel.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        answerTextView.text = question.answers?.first?.body
    }
}
