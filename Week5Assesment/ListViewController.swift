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

class ListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!{
        
        didSet{
            
            registerXIB()
            tableView.dataSource = self
            //tableView.delegate = self
            
            
        }
    }
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcAllBlock()

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
                
                if let bikes = json.array {
                    
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
        
        return listCell
        



    }
    
    
    
}





extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        //configure VC
        // pass in coordinate
        
        
        //show
        self.present(controller, animated: true, completion: nil)

    }
    
    
    
}


