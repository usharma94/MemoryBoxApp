//
//  AddMemoryViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import FirebaseStorage
import FirebaseFirestore
import Kingfisher
import UIKit
import MapKit

class AddMemoryViewController: UIViewController {
    
    @IBOutlet weak var memoryName: UITextField!
    @IBOutlet weak var memoryDesc: UITextField!
    @IBOutlet weak var memoryDate: UIDatePicker!
    @IBOutlet weak var memoryMap: MKMapView!
    @IBOutlet weak var addMemoryBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var memoryImageUID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createMemory() {
        if (self.validateFields()) {
            self.addMemoryBtn.isEnabled = false
            self.uploadImg()
        }
    }
    
    func sendMemoryToDB() {
        let mName = self.memoryName.text!
        let mDesc = self.memoryDesc.text!
        let mDate = self.memoryDate.date
        
        let newMemory = Memory(memoryName: mName, memoryDesc: mDesc, memoryDate: mDate, memoryImage: self.memoryImageUID, x: 1.0, y: 1.0)
        
        let db = Firestore.firestore()
        
        db.collection("memories").addDocument(data: [
            "memory_name": newMemory.memoryName,
            "memory_description": newMemory.memoryDesc,
            "memory_date": newMemory.memoryDate,
            "memory_image": newMemory.memoryImage,
            "memory_location_x": newMemory.xCord,
            "memory_location_y": newMemory.yCord]) { (error) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            
            print("successfully saved memory to database")
        }
        
        self.addMemoryBtn.isEnabled = true
    }
    
    func validateFields() -> Bool {
        if (self.memoryName.text != "" &&
            self.memoryDesc.text != "" &&
            self.imageView.image != nil) {
            return true
        }
        return false
    }

    func uploadImg() {
        guard let image = imageView.image, let data = image.jpegData(compressionQuality: 1.0) else {
            print("Something went wrong with uploading image!")
            return
        }

        let imageName = UUID().uuidString
        let imageRef = Storage.storage().reference()
            .child("imagesFolder")
            .child(imageName)
        
        imageRef.putData(data, metadata: nil) { (metadata, err) in
            if let err = err {
                print("\(err.localizedDescription)")
                return
            }
            
            imageRef.downloadURL(completion: { (url, err) in
                if let err = err {
                    print("\(err.localizedDescription)")
                    return
                }
                
                guard let url = url else {
                    print("Something went wrong with retrieving URL!")
                    return
                }
                
                let urlString = url.absoluteString
                let dataRef = Firestore.firestore().collection("imagesCollection").document()
                let documentUid = dataRef.documentID
                self.memoryImageUID = documentUid
                
                let data = [
                    "uid": documentUid,
                    "imageUrl": urlString
                ]
                
                dataRef.setData(data, completion: { (err) in
                    if let err = err {
                        print("\(err.localizedDescription)")
                        return
                    }
                    
                    print("successfully saved image to database")
                    self.sendMemoryToDB()
                })
            })
        }
    }
    

    //Private functions
    
    private func setupButtons(){
        addMemoryBtn.layer.cornerRadius = 20
    }

}
