//
//  ViewController.swift
//  MemoryBoxApp
//
//  Created by Upma  Sharma on 2019-11-09.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var signupButton: UIButton!
    //Properties
    @IBOutlet weak var loginButton: UIButton!
    
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


}

