//
//  ContextQuestionsViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class ContextQuestionsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var newTopic: Topic?
    var wizardTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addNewQuestionTapped(_ sender: Any) {
    }
}
