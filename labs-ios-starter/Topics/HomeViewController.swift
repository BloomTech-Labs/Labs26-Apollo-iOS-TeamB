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
        joinCodeButton.layer.cornerRadius = 10
        createTopicButton.layer.cornerRadius = 10
    }

    private func setTitle() {
    }

    // MARK: - Actions

    @IBAction func joinCodeButtonTapped(_ sender: Any) {
    }
}
