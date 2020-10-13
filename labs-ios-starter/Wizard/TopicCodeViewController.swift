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
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var newTopic: Topic?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton()
        activityIndicator.startAnimating()
        createNewTopic()
    }

    // MARK: - Actions

    private func styleButton() {
        completedButton.layer.cornerRadius = 5
    }

    private func createNewTopic() {
        guard let newTopic = newTopic else { return }
        UserController.shared.createTopic(newTopic) { topic in
            if let topic = topic {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.joinCodeButton.setTitle(topic.joincode, for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.presentSimpleAlert(with: "ERROR", message: "Failed to create topic", preferredStyle: .alert, dismissText: "OK")
                }
            }
        }
    }

    @IBAction func codeCopyTapped(_ sender: Any) {
        UIPasteboard.general.string = joinCodeButton.titleLabel?.text
    }

    @IBAction func completedButtonTapped(_ sender: Any) {
        if let tabBarController = self.presentingViewController as? UITabBarController {
            self.dismiss(animated: true) {
                tabBarController.selectedIndex = 1
            }
        }
    }
}
