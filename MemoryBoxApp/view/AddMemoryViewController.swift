//
//  AddMemoryViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit

class AddMemoryViewController: UIViewController {
    
    
    @IBOutlet weak var addMemoryBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        // Do any additional setup after loading the view.
    }
    

    //Private functions
    
    private func setupButtons(){
        
        addMemoryBtn.layer.cornerRadius = 20
        
        
    }

}
