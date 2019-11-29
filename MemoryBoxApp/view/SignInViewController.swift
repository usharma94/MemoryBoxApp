//
//  ViewController.swift
//  MemoryBoxApp
//
//  Created by Upma  Sharma on 2019-11-09.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    //Outlets Textfiels
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    //Buttons
    @IBOutlet weak var signupButton: UIButton!
    //Properties
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        
        
    }
    //Private functions
    
    private func setupButtons(){
        
        signupButton.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderWidth = 3
        loginButton.layer.borderColor = UIColor.white.cgColor
        
    }
    //Functions
    
    @IBAction func login(_ sender: UIButton) {
        
        if(txtEmail.text != "" && txtPassword.text != "")
        {
            Auth.auth().signIn(withEmail: txtEmail.text!, password:  txtPassword.text!, completion: {(user, error)  in
                
                if user != nil{
                    print("Successfully Signed In")
                    self.transitionToHome()
                }else{
                    if let myError = error?.localizedDescription
                    {
                        print(myError)
                        self.errorLbl.alpha = 1
                        self.errorLbl.text = "Invalid Login"
                       
                    }else{
                        print("Failed to Login")
                        
                    }
                    
                }
            })
            
        }
        
    }
    
    func transitionToHome() {
          
          let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeViewController
          navigationController?.pushViewController(homeVC, animated: true)
          
      }
    
}

