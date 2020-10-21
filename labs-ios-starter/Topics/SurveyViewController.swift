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
    @IBOutlet var respondButton: UIButton!

    var topicTitle: String?
    var topicId: Int?
    var defaultSurvey: Survey?
    var surveys: [Survey]?
    var selectedSurveyQuestions: [Question]?
    var isLeader: Bool = false
    var surveyId: Int?

    var index: Int?

    var delegate: SurveyRequestDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        updateQuestions()
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

    private func updateQuestions() {
        guard let surveyId = surveyId else { return }

        UserController.shared.fetchSpecificSurvey(with: surveyId) { survey in
            guard let survey = survey, let questions = survey.questions else {
                self.unableToFetchSurveyAlert()
                return
            }

            var memberQuestions: [Question] = []
            for question in questions {
                if question.leader == false {
                    memberQuestions.append(question)
                }
            }

            self.selectedSurveyQuestions = memberQuestions
            self.tableView.reloadData()
        }
    }

    private func setUpView() {
        surveyTableView.isHidden = true
        surveyTableView.separatorStyle = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        surveyButton.layer.borderWidth = 1
        surveyButton.layer.cornerRadius = 5
        respondButton.layer.cornerRadius = 5
        title = topicTitle

        if isLeader {
            respondButton.backgroundColor = UIColor(red: 74/255, green: 43/255, blue: 224/255, alpha: 1)
            respondButton.setTitle("Send Request", for: .normal)
        } else {
            respondButton.backgroundColor = .lightGray
            respondButton.isEnabled = false
            respondButton.setTitle("Respond", for: .normal)
        }
    }

    private func updateViews() {
        tableView.separatorStyle = .singleLine
        respondButton.isEnabled = true
        respondButton.backgroundColor = UIColor(red: 74/255, green: 43/255, blue: 224/255, alpha: 1)
    }

    @IBAction func surveyButtonTapped(_ sender: Any) {
        surveyTableView.isHidden ? animate(toggle: true) : animate(toggle: false)
    }

    @IBAction func respondRequestButtonTapped(_ sender: Any) {
        if isLeader {
            performSegue(withIdentifier: "OwnerRequestSegue", sender: self)
        } else {
            performSegue(withIdentifier: "ContextQuestionsSegue", sender: self)
        }
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
            questionLabel.font = UIFont(name: "Poppins-SemiBold", size: 16)
            questionLabel.numberOfLines = 0
            questionLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
            questionLabel.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 253/255, alpha: 1)
            questionLabel.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
            questionLabel.layer.borderWidth = 1
            questionLabel.layer.cornerRadius = 5
            questionLabel.textAlignment = .center
            return questionLabel
        default:
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case surveyTableView:
            return 0
        default:
            return 50
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
            updateViews()
            let survey = surveys?[indexPath.row]
            let date = String((survey?.createdDate?.split(separator: " ")[0])!)
            surveyButton.setTitle(date, for: .normal)
            index = indexPath.row
            animate(toggle: false)

            if let survey = survey {
                surveyId = survey.surveyid
                updateQuestions()
            }
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
        self.surveys?.insert(request, at: 0)
        self.surveyTableView.reloadData()
        tableView(self.surveyTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
}
