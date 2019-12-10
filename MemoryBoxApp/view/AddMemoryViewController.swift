//
//  AddMemoryViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import MapKit

class AddMemoryViewController: UIViewController {
    
    @IBOutlet weak var memoryName: UITextField!
    @IBOutlet weak var memoryDesc: UITextField!
    @IBOutlet weak var memoryDate: UIDatePicker!
    @IBOutlet weak var memoryMap: MKMapView!
    @IBOutlet weak var addMemoryBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let memoryController = MemoryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createMemory() {
        if (self.validateFields()) {
            self.addMemoryBtn.isEnabled = false
            
            let mName = self.memoryName.text!
            let mDesc = self.memoryDesc.text!
            let mDate = self.memoryDate.date
            
            let newMemory = Memory(memoryName: mName, memoryDesc: mDesc, memoryDate: mDate, memoryImage: "", x: 1.0, y: 1.0)

            self.memoryController.createMemory(imageView: self.imageView, memory: newMemory) { success in
                if (success) {
                    self.addMemoryBtn.isEnabled = success
                    print("user back in control")
                } 
            }
        } else {
            print("Error validating memory creation fields")
        }
    }
    
    func validateFields() -> Bool {
        if (self.memoryName.text != "" &&
            self.memoryDesc.text != "" &&
            self.imageView.image != nil) {
            return true
        }
        return false
    }

    //Private functions
    
    private func setupButtons(){
        addMemoryBtn.layer.cornerRadius = 20
    }

}
