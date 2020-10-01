//
//  SurveyViewController.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 09/09/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var surveyButton: UIButton!
    @IBOutlet var surveyTableView: UITableView!

    var surveys: [Survey] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTableView.isHidden = true
        surveyTableView.separatorStyle = .none
    }

    private func animate(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.surveyTableView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.surveyTableView.isHidden = true
            }
        }
    }

    @IBAction func surveyButtonTapped(_ sender: Any) {
        surveyTableView.isHidden ? animate(toggle: true) : animate(toggle: false)
    }
}

extension SurveyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case surveyTableView:
            return surveys.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView{
        case surveyTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell", for: indexPath)
            let survey = surveys[indexPath.row]
            cell.textLabel?.text = survey.topicId?.description
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyResponseCell", for: indexPath) as? SurveyResponseTableViewCell else { return UITableViewCell() }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case surveyTableView:
            let survey = surveys[indexPath.row]
            surveyButton.setTitle("\(String(describing: survey.surveyId))", for: .normal)
            animate(toggle: false)
        default:
            let threadViewController = ThreadViewController()
            threadViewController.title = "Thread"
            navigationController?.pushViewController(threadViewController, animated: true)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
