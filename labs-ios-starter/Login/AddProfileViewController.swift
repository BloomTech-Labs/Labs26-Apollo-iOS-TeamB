//
//  AddUserViewController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

protocol AddUserDelegate: class {
    func userWasAdded()
}

class AddUserViewController: UIViewController {

    // MARK: - Properties and Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var avatarURLTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: AddUserDelegate?
    
    var userController: UserController = UserController.shared
    var keyboardDismissalTapRecognizer: UITapGestureRecognizer!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpKeyboardDismissalRecognizer()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        avatarURLTextField.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addUser(_ sender: Any) {
        
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let avatarURLString = avatarURLTextField.text,
            let avatarURL = URL(string: avatarURLString) else {
                NSLog("Fields missing information. Present alert to notify user to enter all information.")
                return
        }
        
        activityIndicator.startAnimating()
        
//        userController.addUser(user) { [weak self] in
//            
//            guard let self = self else { return }
//            
//            self.activityIndicator.stopAnimating()
//            self.dismiss(animated: true, completion: {
//                self.delegate?.userWasAdded()
//            })
//        }
    }
    
    // MARK: - Private Methods
    
    private func setUpKeyboardDismissalRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(recognizer)
        keyboardDismissalTapRecognizer = recognizer
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension AddUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            avatarURLTextField.becomeFirstResponder()
        case avatarURLTextField:
            avatarURLTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
