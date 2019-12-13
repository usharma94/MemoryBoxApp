//
//  MemoryDetailViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import MapKit

class MemoryDetailViewController: UIViewController {
    
    @IBOutlet weak var memoryName: UILabel!
    @IBOutlet weak var memoryDesc: UILabel!
    @IBOutlet weak var memoryDate: UILabel!
    @IBOutlet weak var memoryMap: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    var memory = Memory()
    let memoryController = MemoryController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.memoryName.text = self.memory.memoryName
        self.memoryDesc.text = self.memory.memoryDesc
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = format.string(from: self.memory.memoryDate)
        self.memoryDate.text = date
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       self.memoryController.downloadImg(imageView: self.imageView, uid: memory.memoryImage)
        
        self.setupMap()
    }
    
    func setupMap() {
        self.memoryMap.mapType = MKMapType.satellite
        
        let location = CLLocationCoordinate2D(latitude: self.memory.xCord, longitude: self.memory.yCord)
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = location
        myAnnotation.title = "Your Memory Location"
        self.memoryMap.addAnnotation(myAnnotation)
        
        //center map around pin
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
        self.memoryMap.setRegion(region, animated: true)
    }
    

    @IBAction func shareMemory() {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userListVC = mainSB.instantiateViewController(withIdentifier: "UserList") as! UserListTableViewController
        
        userListVC.memoryUID = self.memory.memoryID
        
        navigationController?.pushViewController(userListVC, animated: true)
    }

}
