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
    
    
    //dont touch
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //check fields and validate that data is correct, if corret returns nil
    
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
            
            let firstName = txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = txtPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            //create the user
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                
                //check for errors
                if let err = err{
                    //there was an error
                    self.showError("Error creating new user")
                    print(err.localizedDescription)
                }else{
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["email": email!,"first_name":firstName!, "last_name":lastName!, "phone": phone!, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                            print(error?.localizedDescription)
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
            //transition to home screen
            
        }
        
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
