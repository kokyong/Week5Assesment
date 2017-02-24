//
//  CurrentLocationViewController(Extension).swift
//  Week5Assesment
//
//  Created by Kok Yong on 24/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


extension CurrentLocationViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        currentLocationMap.setRegion(region, animated: true)
        
        print(location.altitude)
        print(location.speed)
        print(location.coordinate.longitude)
        print(location.coordinate.latitude)
        
        self.currentLatitude = location.coordinate.latitude
        self.currentLongitude = location.coordinate.longitude
        
        self.currentLocationMap.showsUserLocation = true
        
    }
}

extension CurrentLocationViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation.title! == "ME"{
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: currentAnnotationIdentifier){
                
                annotationView.annotation = annotation
                return annotationView
                
            }else{
                
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: currentAnnotationIdentifier)
                annotationView.image = UIImage(named: "bikeIcon")
                
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                return annotationView
            }
        }else {
            
            return nil
        }
    }
    
}

