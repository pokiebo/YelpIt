//
//  Restaurant.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 8/16/18.
//  Copyright © 2018 Sudipta Bhowmik. All rights reserved.
//

import Foundation
import MapKit

class Restaurant: NSObject, MKAnnotation {
    var identifier = "restaurant location"
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
    var subtitle: String? {
        return title
    }
    
    /*init(dictionary : NSDictionary) {
        locationName = dictionary["name"] as? String
        
        if let coords = dictionary["coordinates"] as? NSDictionary {
            lat = coords["latitude"]
            long = coords["longitude"]
            coordinate = CLLocationCoordinate2DMake(lat, long)
        }
        //coordinate = CLLocationCoordinate2DMake(CLLocationDegrees, <#T##longitude: CLLocationDegrees##CLLocationDegrees#>)
    }*/
    
}
