//
//  ListViewController.swift
//  Week5Assesment
//
//  Created by Kok Yong on 24/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import MapKit
import CoreLocation

class ListViewController: UIViewController {

    let manager = CLLocationManager()
    
    var currentLocationLatitude = Double()
    var currentLocationLongitude = Double()
    
    var destinationLatitude = Double()
    var destinationLongitude = Double()
    
    var destinationAnnotation = MKPointAnnotation()
    var bikeShop = String()
    
    let locationManager = CLLocationManager()
    
    let destinationAnnotationIdentifier = ""


    
    @IBOutlet weak var tableView: UITableView!{
        
        didSet{
            
            registerXIB()
            tableView.dataSource = self
            //tableView.delegate = self
            
            
        }
    }
    
    @IBOutlet weak var listMapView: MKMapView!
    
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcAllBlock()
        location()
        annotationFunc()
        locationManagerFunc()
        //mapView.delegate = self


    }
    
    func location() {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    
    func registerXIB() {
        
        tableView.register(ListTableViewCell.cellNib, forCellReuseIdentifier: ListTableViewCell.cellIdentifier)
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func fetcAllBlock() {
        
        let url = "https://feeds.citibikenyc.com/stations/stations.json"
        
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                if let bikes = json["stationBeanList"].array {
                    
                    for bike in bikes {
                        
                        let newBike = BikeStation(json : bike)
                        BikeStation.allBike.append(newBike)
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

    func annotationFunc() {
        
        destinationAnnotation.coordinate = CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude)
        destinationAnnotation.title = bikeShop
        listMapView.addAnnotation(destinationAnnotation)
        
    }

    func locationManagerFunc() {
        
        //gps used when needed (GPS)
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
    }


}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BikeStation.allBike.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdentifier, for: indexPath) as? ListTableViewCell
        
                    else {
                        return UITableViewCell()
                }
        
        let bikeIndex = BikeStation.allBike[indexPath.row]
        
        listCell.bikeShopLabel?.text = bikeIndex.stationName
        listCell.availableBikesLable?.text = bikeIndex.availableBikes
        
        self.destinationLatitude = bikeIndex.latitude
        self.destinationLongitude = bikeIndex.longitude
        
        self.bikeShop = bikeIndex.stationName
        
        return listCell
        



    }
    
    
    
}





extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//        
//        //configure VC
//        // pass in coordinate
//        
//        
//        //show
//        self.present(controller, animated: true, completion: nil)
        
        

    }
    
    
    
}

extension ListViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        listMapView.setRegion(region, animated: true)
        
        print(location.altitude)
        print(location.speed)
        print(location.coordinate.longitude)
        print(location.coordinate.latitude)
        
        self.currentLocationLatitude = location.coordinate.latitude
        self.currentLocationLongitude = location.coordinate.longitude

        
        self.listMapView.showsUserLocation = true
        
    }
}

//delegate
extension ListViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation.title! == bikeShop {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: destinationAnnotationIdentifier){
                
                annotationView.annotation = annotation
                return annotationView
                
            }else{
                
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: destinationAnnotationIdentifier)
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
        
        let region = MKCoordinateRegionMake(destinationAnnotation.coordinate, span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
}





