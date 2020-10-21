//
//  UIViewController+SimpleAlert.swift
//  labs-ios-starter
//
//  Created by Spencer Curtis on 7/30/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentSimpleAlert(with title: String?,
                            message: String?,
                            preferredStyle: UIAlertController.Style = .alert,
                            dismissText: String = "OK",
                            completionUponDismissal: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let dismissAction = UIAlertAction(title: dismissText, style: .cancel, handler: completionUponDismissal)
        alert.addAction(dismissAction)
        
        present(alert, animated: true, completion: nil)
    }

    func unableToFetchContextsAlert() {
        presentSimpleAlert(with: "Error displaying contexts",
                           message: "We are currently unable to display the survey types. Please try again later") { _ in
                            self.dismiss(animated: true, completion: nil)
        }
    }

    func unableToCreateTopicAlert() {
        presentSimpleAlert(with: "Error creating topic",
                           message: "We are currently unable to create a new topic. Please try again later") { _ in
                            self.dismiss(animated: true, completion: nil)
        }
    }

    func unableToFetchTopicsAlert() {
        presentSimpleAlert(with: "Error fetching topics",
                           message: "We are currently unable to get topics from server. Please try again later")
    }

    func unableToFetchSurveyAlert() {
        presentSimpleAlert(with: "Error fetching survey",
                           message: "Failed to get questions for the selected survey. Please try again later")
    }

    func unableToFetchLeaderQuestionsAlert() {
        presentSimpleAlert(with: "Error displaying questions",
                           message: "We are currently unable to get leader questions from server. Please try again later") { _ in
                            self.popToSurveyViewController()
        }
    }

    func unableToAnswerRequestAlert() {
        presentSimpleAlert(with: "Error posting answers",
                           message: "We are currently unable to send your responses to our server. Please try again later") { _ in
                            self.popToSurveyViewController()
        }
    }

    func unableToGetDefaultQuestionsAlert() {
        presentSimpleAlert(with: "Error displaying questions",
                           message: "We are currently unable to get default questions from our server. Please try again later") { _ in
                            self.popToSurveyViewController()
        }
    }

    func errorSendingRequestAlert() {
        presentSimpleAlert(with: "Error sending survey request",
                           message: "Failed to get a result from our server. Please try again later") { _ in
                            self.popToSurveyViewController()
        }
    }

    func unableToDeleteTopicAlert() {
        presentSimpleAlert(with: "Error deleting topic",
                           message: "Failed to delete topic. Please try again later")
    }

    func unableToLeaveTopicAlert() {
        presentSimpleAlert(with: "Error leaving topic",
                           message: "Failed to leave topic. Please try again later")
    }

    private func popToSurveyViewController() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: SurveyViewController.self) {
                self.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }
}
