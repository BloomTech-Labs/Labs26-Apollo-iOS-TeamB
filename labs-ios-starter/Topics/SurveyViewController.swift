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

    var surveys: [Survey]?
    var selectedSurveyQuestions: [Question]?

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
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case self.tableView:
            return selectedSurveyQuestions?[section].body
        default:
            return nil
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case self.tableView:
            guard let questionCount = selectedSurveyQuestions?.count else { return 0 }
            return questionCount
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case surveyTableView:
            return surveys?.count ?? 0
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView{
        case surveyTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell", for: indexPath)
            let survey = surveys?[indexPath.row]
            let date = String((survey?.createdDate?.split(separator: " ")[0])!)
            cell.textLabel?.text = date
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyResponseCell", for: indexPath) as? SurveyResponseTableViewCell else { return UITableViewCell() }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case surveyTableView:
            let survey = surveys?[indexPath.row]
            let date = String((survey?.createdDate?.split(separator: " ")[0])!)
            surveyButton.setTitle(date, for: .normal)
            animate(toggle: false)

            var memberQuestions:[Question] = []
            if let survey = survey,
               let questions = survey.questions {
                for question in questions {
                    if !(question.leader ?? false) {
                        memberQuestions.append(question)
                    }
                }
            }
            self.selectedSurveyQuestions = memberQuestions
            self.tableView.reloadData()
        default:
            let threadViewController = ThreadViewController()
            threadViewController.title = "Thread"
            navigationController?.pushViewController(threadViewController, animated: true)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
