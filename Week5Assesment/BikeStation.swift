//
//  BikeStation.swift
//  Week5Assesment
//
//  Created by Kok Yong on 24/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import SwiftyJSON

class BikeStation {
    
    static var allBike : [BikeStation] = []
    
    var stationName : String
    var latitude : Double
    var longitude : Double
    var availableBikes : String
    
    init (json : JSON) {
        
        stationName = json["stationName"].stringValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        availableBikes = json["availableBikes"].stringValue

        
        
    }
    
    
    
    
    
}
