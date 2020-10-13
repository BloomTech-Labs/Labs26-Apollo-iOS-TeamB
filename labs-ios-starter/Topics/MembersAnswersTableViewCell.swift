//
//  MembersAnswersTableViewCell.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 12/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class MembersAnswersTableViewCell: UITableViewCell {

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

        if question.bo
        answerTextView.text = ""
    }
}
