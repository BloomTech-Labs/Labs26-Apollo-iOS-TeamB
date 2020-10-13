//
//  HomeViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var userAvatar: UIButton!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var joinCodeButton: UIButton!
    @IBOutlet var createTopicButton: UIButton!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        styleButtons()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Methods

    private func styleButtons() {
        joinCodeButton.layer.cornerRadius = 5
        createTopicButton.layer.cornerRadius = 5
    }

    private func setTitle() {
    }

    // MARK: - Actions

    @IBAction func joinCodeButtonTapped(_ sender: Any) {
        guard let joincode = codeTextField.text,
              !joincode.isEmpty else {
            self.presentSimpleAlert(with: "ERROR", message: "Please enter a valid join code.", preferredStyle: .alert, dismissText: "OK")
            return
        }

        UserController.shared.joinTopic(joincode) { result in
            DispatchQueue.main.async {
                if result {
                    self.presentSimpleAlert(with: "Success", message: "You have successfully joined the topic!", preferredStyle: .alert, dismissText: "OK") { _ in
                        self.codeTextField.text = ""
                        self.tabBarController?.selectedIndex = 1
                    }
                } else {
                    self.presentSimpleAlert(with: "ERROR", message: "There was an error joining the topic. Please make sure you inputed the correct join code.", preferredStyle: .alert, dismissText: "OK")
                }
            }
        }
    }
}
