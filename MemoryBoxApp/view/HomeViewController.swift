//
//  HomeViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
@IBOutlet weak var newMemoryButton: UIButton!
    @IBOutlet weak var viewMemoryButton: UIButton!
    @IBOutlet weak var memoryMapButton:
    UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        // Do any additional setup after loading the view.
    }
    
    private func setupButtons(){
        
        newMemoryButton.layer.cornerRadius = 20
        viewMemoryButton.layer.cornerRadius = 20
        memoryMapButton.layer.cornerRadius = 20
       
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
