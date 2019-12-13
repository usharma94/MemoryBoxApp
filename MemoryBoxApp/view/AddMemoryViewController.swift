//
//  AddMemoryViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddMemoryViewController: UIViewController {
    
    @IBOutlet weak var memoryName: UITextField!
    @IBOutlet weak var memoryDesc: UITextField!
    @IBOutlet weak var memoryDate: UIDatePicker!
    @IBOutlet weak var memoryMap: MKMapView!
    @IBOutlet weak var addMemoryBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let memoryController = MemoryController()
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 200
    var mapCords: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()

        memoryMap.mapType = MKMapType.satellite
        memoryMap.isZoomEnabled = true
        memoryMap.isScrollEnabled = true
        memoryMap.isUserInteractionEnabled = true
        
        //set up locationmanager properties
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        //start getting the location updates using the callback created
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.startUpdatingLocation()
            addLongPressGesture()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createMemory() {
        if (self.validateFields()) {
            self.addMemoryBtn.isEnabled = false
            
            let mName = self.memoryName.text!
            let mDesc = self.memoryDesc.text!
            let mDate = self.memoryDate.date
            
            let newMemory = Memory(memoryID: "", memoryName: mName, memoryDesc: mDesc, memoryDate: mDate, memoryImage: "", x: self.mapCords?.latitude ?? 0.0, y: self.mapCords?.longitude ?? 0.0)

            self.memoryController.createMemory(imageView: self.imageView, memory: newMemory) { success in
                if (success) {
                    self.addMemoryBtn.isEnabled = success
                    
                    self.transitionToHome()
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
    
    func transitionToHome() {
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene") as! HomeViewController
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

extension AddMemoryViewController : MKMapViewDelegate {
    func addLongPressGesture(){
        let longPressRecogniser:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target:self , action:#selector(AddMemoryViewController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0 //user needs to press for 2 seconds
        self.memoryMap.addGestureRecognizer(longPressRecogniser)
    }

    @objc func handleLongPress(_ gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state != .began{
            return
        }
        
        let allAnnotations = self.memoryMap.annotations
        self.memoryMap.removeAnnotations(allAnnotations)
        
        let touchPoint:CGPoint = gestureRecognizer.location(in: self.memoryMap)
        let touchMapCoordinate:CLLocationCoordinate2D =
            self.memoryMap.convert(touchPoint, toCoordinateFrom: self.memoryMap)
        
        self.mapCords = touchMapCoordinate
        
        self.resetTracking()
        
        //Drop a pin at user's current location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = touchMapCoordinate //where to display...provide 2D coordinates...Lat and Long
        myAnnotation.title = "Your Memory Location"
        
        //add the pin on the map
        memoryMap.addAnnotation(myAnnotation)
        
        //center map around pin
        let region = MKCoordinateRegion(center: touchMapCoordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.memoryMap.setRegion(region, animated: true)
    }
    
    func resetTracking(){
        if (self.memoryMap.showsUserLocation){
            self.memoryMap.showsUserLocation = false
            self.memoryMap.removeAnnotations(self.memoryMap.annotations)
            self.locationManager.stopUpdatingLocation()
        }
    }
}

extension AddMemoryViewController : CLLocationManagerDelegate {
    
    //print an error if anything goes wrong
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    //handles the changes in the permission for location access
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            //when permission is given for location access while app is running ask the location manager to get the current location
            locationManager.requestLocation()
        case .authorizedAlways:
            //code to operate in background using location access
            break
        case .denied:
            //operations to be done if permission is denied
            //for example, go to settings and change permissions
            //display Alert using various possibilities or limitation of facilities
            break
        case .notDetermined:
            //if user has neither approved nor rejected permission
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
    
    //handles location requests and updates
    //also display the location on Map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //if any previous locations are available get most recent one
        //You may optionally display the location on map instead of displaying on console
        if locations.last != nil{
            print("location :: \(locations.last)")
        }
        
        print("Updating location")
        
        //create a center point of our location to be displayed on map using current latitude and longitude
        let center = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        self.mapCords = center
        
        //create a region to be displayed on map using the 2D coordinates
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        //display the region on map
        self.memoryMap.setRegion(region, animated: true)
        
        //Drop a pin at user's current location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = center //where to display...provide 2D coordinates...Lat and Long
        myAnnotation.title = "You are here !"
        
        //add the pin on the map
        memoryMap.addAnnotation(myAnnotation)
    }
}

