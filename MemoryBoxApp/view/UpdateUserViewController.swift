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
    
     var updateController = UpdateUserController()
     var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUpdate.layer.cornerRadius = 20

       
    }
    

    @IBAction func updateClick(_ sender: UIButton) {
       
}
}
