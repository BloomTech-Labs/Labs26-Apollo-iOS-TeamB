//
//  TopicCodeViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class TopicCodeViewController: UIViewController {

    @IBOutlet var completedButton: UIButton!
    @IBOutlet var joinCodeButton: UIButton!

    var joinCode: String?
    var newTopic: Topic?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton()
        createNewTopic()
    }

    // MARK: - Actions

    private func styleButton() {
        completedButton.layer.cornerRadius = 10
    }

    private func createNewTopic() {
        guard let newTopic = newTopic else { return }
        UserController.shared.createTopic(newTopic) { topic in
            if let topic = topic,
                let joinCode = topic.joincode {

                DispatchQueue.main.async {
                    self.joinCodeButton.setTitle(joinCode, for: .normal)
                }
            }
        }
    }

    @IBAction func codeCopyTapped(_ sender: Any) {
    }

    @IBAction func completedButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // TODO: - Present the topics tab
    }
}
