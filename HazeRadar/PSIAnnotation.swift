//
//  PSIAnnotation.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import MapKit

class PSIAnnotation: NSObject, MKAnnotation {
    let title: String?
    let region: String
    let coordinate: CLLocationCoordinate2D
    
    init(psi: String, region: String, coordinate: CLLocationCoordinate2D) {
        self.title = psi
        self.region = region
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return region
    }
}
