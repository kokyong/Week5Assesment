//
//  CurrentLocationViewController.swift
//  Week5Assesment
//
//  Created by Kok Yong on 24/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrentLocationViewController: UIViewController {
    
    let currentAnnotationIdentifier = "ME"
    let manager = CLLocationManager()
    let currentAnnocation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    
    var currentLatitude = Double()
    var currentLongitude = Double()
    
    
    
    @IBOutlet weak var currentLocationMap: MKMapView!
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        
        
        annotationFunc()
        
        locationManagerFunc()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func annotationFunc() {
        
        currentAnnocation.coordinate = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        currentAnnocation.title = "ME"
        currentLocationMap.addAnnotation(currentAnnocation)
        
    }
    
    func locationManagerFunc() {
        
        //gps used when needed (GPS)
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
    }
    
    
    
    
    
    
    
}



