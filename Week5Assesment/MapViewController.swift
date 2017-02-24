//
//  MapViewController.swift
//  Week5Assesment
//
//  Created by Kok Yong on 24/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var BikeShopLableMap: UILabel!
    @IBOutlet weak var availableBikeLableMap: UILabel!
    @IBOutlet weak var distanceAwayLabelMap: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var bikeAnnotaion = MKPointAnnotation()
    var bikeAnnotaionIdentifier = "BIKE"
    let locationManager = CLLocationManager()
    
    let longitude = Double()
    let latitude = Double()
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        annotationFunc()
        locationManagerFunc()
        
        
    }
    
    func locationManagerFunc() {
        
        //gps used when needed (GPS)
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
    }
    
    func annotationFunc() {
        
        bikeAnnotaion.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        
        bikeAnnotaion.title = self.BikeShopLableMap.text
        mapView.addAnnotation(bikeAnnotaion)
        
    }
    
}


extension MapViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation.title! == self.BikeShopLableMap.text {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: bikeAnnotaionIdentifier){
                
                annotationView.annotation = annotation
                return annotationView
                
            }else{
                
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: bikeAnnotaionIdentifier)
                annotationView.image = UIImage(named: "bikeIcon")
                
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                return annotationView
            }
        }else {
            
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        let region = MKCoordinateRegionMake(bikeAnnotaion.coordinate, span)
        
        mapView.setRegion(region, animated: true)
        
    }

}

