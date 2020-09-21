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

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton()
    }

    // MARK: - Actions

    private func styleButton() {
        completedButton.layer.cornerRadius = 10
    }

    @IBAction func codeCopyTapped(_ sender: Any) {
    }

    @IBAction func completedButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // TODO: - Present the topics tab
    }
}
