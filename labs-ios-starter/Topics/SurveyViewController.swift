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
    @IBOutlet var respondRequestButton: UIButton!

    var topicTitle: String?
    var topicId: Int?
    var defaultSurvey: Survey?
    var surveys: [Survey]?
    var selectedSurveyQuestions: [Question]?
    var index: Int?

    var delegate: SurveyRequestDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTableView.isHidden = true
        surveyTableView.separatorStyle = .none
        setUpView()
        self.delegate = self
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

    private func setUpView() {
        surveyButton.layer.borderWidth = 1
        respondRequestButton.layer.borderWidth = 1
        title = topicTitle
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44
    }

    @IBAction func surveyButtonTapped(_ sender: Any) {
        surveyTableView.isHidden ? animate(toggle: true) : animate(toggle: false)
    }

    @IBAction func answerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ContextQuestionsSegue", sender: self)
    }

    @IBAction func respondRequestButtonTapped(_ sender: Any) {
        // Here there will be a check if you are the leader or not
        performSegue(withIdentifier: "OwnerRequestSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContextQuestionsSegue" {
            if let destinationVC = segue.destination as? LeaderAnswersViewController,
                let index = index {
                destinationVC.surveyId = surveys?[index].surveyid
            }
        } else if segue.identifier == "OwnerRequestSegue" {
            if let destinationVC = segue.destination as? RequestContextViewController {
                destinationVC.defaultSurvey = defaultSurvey
                destinationVC.topicId = topicId
                destinationVC.delegate = delegate
            }
        }
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case self.tableView:
            let questionLabel = UILabel()
            questionLabel.font = UIFont.boldSystemFont(ofSize: 18)
            questionLabel.numberOfLines = 0
            questionLabel.textAlignment = .center
            questionLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
            questionLabel.backgroundColor = UIColor.opaqueSeparator

            return questionLabel
        default:
            return UIView()
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
            guard let answerCount = selectedSurveyQuestions?[section].answers?.count else { return 0 }
            return answerCount
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyResponseCell", for: indexPath) as? SurveyResponseTableViewCell else {
                return UITableViewCell()
            }

            cell.usernameLabel.text = selectedSurveyQuestions?[indexPath.section].answers?[indexPath.row].username
            cell.responseTextView.text = selectedSurveyQuestions?[indexPath.section].answers?[indexPath.row].body
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case surveyTableView:
            let survey = surveys?[indexPath.row]
            let date = String((survey?.createdDate?.split(separator: " ")[0])!)
            surveyButton.setTitle(date, for: .normal)
            index = indexPath.row
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

extension SurveyViewController: SurveyRequestDelegate {
    func didGetSurveyRequest(_ request: Survey) {
        self.surveys?.append(request)
        self.surveyTableView.reloadData()
        var newMemberQuestions: [Question] = []
        guard let questions = request.questions else { return }
        for question in questions {
            if !(question.leader ?? false) {
                newMemberQuestions.append(question)
            }
        }
        self.selectedSurveyQuestions = newMemberQuestions
        self.tableView.reloadData()
    }
}
