//
//  SignUpViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblErrorMsg: UILabel!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    let userController = UserController()
    
    //dont touch
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        
        // Do any additional setup after loading the view.
    }
    //check fields and validate that data is correct, if corret returns nil
    
    //***********************************
    //***********************************
    //NON UI CODE NEEDS TO BE MOVED TO CONTROLLER 
    //***********************************
    //***********************************
    
    func validateFields() -> String? {
        
        //check all fields filled in
        if  txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    
    @IBAction func btnSignUp(_ sender: Any) {
    
        //validate the fields
        let error = validateFields()
        
        if error != nil {
            //something wrong with fields show error message
            showError(error!)
        }else{
            
            let firstName = (txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            let lastName = (txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            let phone = (txtPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            let email = (txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            let password = (txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            //create the user
            let newUser = User(firstName: firstName, lastName: lastName, phone: phone, email: email, password: password, userMemory: [])
            
            self.userController.createUser(newUser: newUser)
            // Transition to the home screen
            self.transitionToHome()
        }
            
    }
    
    private func setupButtons(){
          
          signupBtn.layer.cornerRadius = 20
          
          
      }
    
    func showError(_ message: String){
        lblErrorMsg.text = message
        lblErrorMsg.alpha = 1
    }
    
    func transitionToHome() {
        
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeViewController
        navigationController?.pushViewController(homeVC, animated: true)
        
    }
    
    //dont touch
}
