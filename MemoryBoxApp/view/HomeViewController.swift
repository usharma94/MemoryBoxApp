//
//  HomeViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    @IBOutlet weak var newMemoryButton: UIButton!
    @IBOutlet weak var viewMemoryButton: UIButton!
    @IBOutlet weak var memoryMapButton:
    UIButton!
    
    @IBOutlet weak var updateUserButton: UIButton!
    
    @IBOutlet weak var manualButton: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().currentUser?.email
        
        setupButtons()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupButtons(){
        
        newMemoryButton.layer.cornerRadius = 20
        viewMemoryButton.layer.cornerRadius = 20
        memoryMapButton.layer.cornerRadius = 20
        logoutBtn.layer.cornerRadius = 20
        manualButton.layer.cornerRadius = 20
        updateUserButton.layer.cornerRadius = 20
        
        
    }
    
    
    @IBAction func logoutClick(_ sender: UIButton) {
        
        try! Auth.auth().signOut()
        print("logout successful")
        performSegue(withIdentifier: "logoutsegue", sender: self)
    }
    
}
