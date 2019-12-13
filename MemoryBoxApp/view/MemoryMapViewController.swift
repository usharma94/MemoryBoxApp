//
//  MemoryMapViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MemoryMapViewController: UIViewController {
    
    @IBOutlet weak var memoryMap: MKMapView!
    
    private var memoryList = [Memory]()
    let memoryController = MemoryController()
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()

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
        }
        
        self.memoryController.getAllMemories() { list in
            self.memoryList = list
            self.setPins()
        }
    }

    func setPins() {
        for memory in self.memoryList {
            let location = CLLocationCoordinate2D(latitude: memory.xCord, longitude: memory.yCord)
            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = location
            myAnnotation.title = "Memory Location"
            self.memoryMap.addAnnotation(myAnnotation)
        }
    }
}

extension MemoryMapViewController : CLLocationManagerDelegate {
    
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

        //create a region to be displayed on map using the 2D coordinates
        var region = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
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

