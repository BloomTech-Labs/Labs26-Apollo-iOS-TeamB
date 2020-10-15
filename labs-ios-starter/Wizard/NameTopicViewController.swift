//
//  NameTopicViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 10/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class NameTopicViewController: ShiftableViewController {

    // MARK: - Outlets

    @IBOutlet var topicNameTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var nextButton: UIBarButtonItem!

    // MARK: - Properties

    var selectedFrequency: FrequencyTableViewCell?
    var selectedContext: Context?
    let frequencyArray = ["Daily", "Weekly", "Monthly", "Custom", "Off"]

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.isEnabled = false
        topicNameTextField.delegate = self
        topicNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

        if let selectedContext = selectedContext {
            title = "\(selectedContext.description.split(separator: " ")[0].capitalized) Topic"
        }
    }

    // MARK: - Methods

    @objc func textFieldDidChange(_ textField: UITextField) {
        if !(topicNameTextField.text?.isEmpty ?? false) && (selectedFrequency != nil) {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContextQuestionsSegue" {
            guard
                let vc = segue.destination as? ContextQuestionsViewController,
                let topicTitle = topicNameTextField.text,
                let frequency = selectedFrequency?.frequencyLabel?.text else { return }

            let newTopic = Topic()
            newTopic.title = topicTitle
            newTopic.frequency = frequency.uppercased()
            vc.newTopic = newTopic
            vc.selectedContext = selectedContext
        }
    }
}

extension NameTopicViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frequencyArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FrequencyCell", for: indexPath) as? FrequencyTableViewCell else { return UITableViewCell() }

        cell.frequencyLabel.text = frequencyArray[indexPath.row]
        cell.checkmarkImageView.image = UIImage(systemName: "circle")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedFrequency = self.selectedFrequency {
            selectedFrequency.checkmarkImageView.image = UIImage(systemName: "circle")
        }

        guard let indexPath = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: indexPath) as? FrequencyTableViewCell else { return }
        cell.checkmarkImageView.image = UIImage(systemName: "checkmark.circle")

        self.selectedFrequency = cell
        if !(topicNameTextField.text?.isEmpty ?? false) {
            nextButton.isEnabled = true
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
