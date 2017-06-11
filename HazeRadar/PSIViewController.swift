//
//  ViewController.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import UIKit
import MapKit

class PSIViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var psiData:PSIData?
    var currentDate = Date()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        loadPSI()
    }

    
    func loadPSI(){

        PSI().load(date: currentDate, success: { (data) in
            
            self.psiData = data
            
            DispatchQueue.main.async {
                self.showAnnotations()
            }
            
        }) { (message) in
            print(message)
        }
    }
    
}

