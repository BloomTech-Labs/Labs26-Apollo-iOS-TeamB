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
}
