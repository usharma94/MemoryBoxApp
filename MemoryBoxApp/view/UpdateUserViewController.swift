//
//  UpdateUserViewController.swift
//  MemoryBoxApp
//
//  Created by Upma  Sharma on 2019-12-12.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import Firebase

class UpdateUserViewController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUpdate: UIButton!
    
     var userController = UserController()
     var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUpdate.layer.cornerRadius = 20

        retrieveUser()
    }
    
    func retrieveUser() {
        self.userController.getUserProfile() { user in
            self.user = user
            self.setupFields()
        }
    }
    
    func setupFields() {
        self.txtFirstName.text = self.user.firstName
        self.txtLastName.text = self.user.lastName
        self.txtEmail.text = self.user.email
        self.txtPhone.text = self.user.phone
    }
    

    @IBAction func updateClick(_ sender: UIButton) {
        self.user.firstName = self.txtFirstName.text ?? self.user.firstName
        self.user.lastName = self.txtLastName.text ?? self.user.lastName
        self.user.email = self.txtEmail.text ?? self.user.email
        self.user.phone = self.txtPhone.text ?? self.user.phone
        self.userController.updateUser(updateUser: self.user)
        
        if (self.txtPassword.text != "") {
            self.userController.updateUserPassword(newPassword: self.txtPassword.text ?? "")
        }
        
        self.transitionToHome()
    }
    
    func transitionToHome() {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeViewController
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
