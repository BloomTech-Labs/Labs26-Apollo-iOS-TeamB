//
//  QuestionsTableViewCell.swift
//  labs-ios-starter
//
//  Created by Hunter Oppel on 9/29/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class QuestionsTableViewCell: UITableViewCell {
    @IBOutlet var questionNumberLabel: UILabel!
    @IBOutlet var questionBodyTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        textViewSetup()
    }

    private func textViewSetup() {
        questionBodyTextView.text = ""
        questionBodyTextView.layer.cornerRadius = 5
        questionBodyTextView.layer.borderWidth = 1
        questionBodyTextView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    }
}
