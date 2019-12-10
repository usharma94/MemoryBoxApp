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
