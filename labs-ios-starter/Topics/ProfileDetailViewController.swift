//
//  UserDetailViewController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var editStackView: UIStackView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var avatarURLTextField: UITextField!
    
    var userController: UserController = UserController.shared
    var user: OktaProfile?
    var isUsersUser = true
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    @IBAction func cancelUserUpdate(_ sender: Any) {
        setEditing(false, animated: true)
    }
    
    @IBAction func updateUser(_ sender: Any) {
        
        guard let user = userController.authenticatedUserUser,
            let name = nameTextField.text,
            let email = emailTextField.text,
            let avatarURLString = avatarURLTextField.text,
            let avatarURL = URL(string: avatarURLString) else {
                presentSimpleAlert(with: "Some information was missing",
                                   message: "Please enter all information in, and ensure the avatar URL is in the correct format.",
                                   preferredStyle: .alert,
                                   dismissText: "Dismiss")
                
                return
        }
        
        userController.updateAuthenticatedUserUser(user, with: name, email: email, avatarURL: avatarURL) { [weak self] (updatedUser) in
            
            guard let self = self else { return }
            self.updateViews(with: updatedUser)
        }
    }
    
    // MARK: - Private Methods
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        editStackView.isHidden = !editing
        
        if editing {
            navigationItem.rightBarButtonItem = nil
        } else {
            navigationItem.rightBarButtonItem = editButtonItem
        }
    }
    
    
    // MARK: View Setup
    
    private func updateViews() {
        
        if let user = user {
            title = "Details"
            updateViews(with: user)
        } else if isUsersUser,
            let user = userController.authenticatedUserUser {
            title = "Me"
            updateViews(with: user)
        }
    }
    
    private func updateViews(with user: OktaProfile) {
        guard isViewLoaded else { return }
        
        nameLabel.text = user.name


        
        guard isUsersUser else { return }
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        nameTextField.text = user.name
    }
}
