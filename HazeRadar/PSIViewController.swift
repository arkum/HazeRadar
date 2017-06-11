//
//  ViewController.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import UIKit
import MapKit
import ProgressHUD

class PSIViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var psiData:PSIData?
    var currentDate = Date()
    
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var pagerContainer: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupMapView()
        loadPSI()
    }
    
    @IBAction func refreshTouched(_ sender: Any) {
        currentDate = Date()
        loadPSI()
    }
    
    @IBAction func next(_ sender: Any) {
        if (!Calendar.current.isDateInToday(currentDate)){
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            loadPSI()
        }
    }

    @IBAction func previous(_ sender: Any) {
        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        loadPSI()
    }
    
    func loadPSI(){
        resetNextButton()
        ProgressHUD.show("Measuring PSI..", interaction: false)
        PSI().load(date: currentDate, success: { (data) in
            
            self.psiData = data
            
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                self.showDate()
                self.showAnnotations()
            }
            
        }) { (message) in
            ProgressHUD.showError(message)
        }
    }
    
    func showDate(){
        if (Calendar.current.isDateInToday(currentDate)){
            dateLabel.text = "Today"
        }
        else{
            dateLabel.text = currentDate.description
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateLabel.text = dateFormatter.string(from: currentDate)
        }
    }
    
    func setup(){
        dateLabel.text = "loading.."
        pagerContainer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        Utility.roundEdgeWithShadow(view: pagerContainer, radius: pagerContainer.frame.height/2)
        Utility.roundEdgeWithShadow(view: refreshButton, radius: refreshButton.frame.height/2)
    }
    
    func resetNextButton(){
        nextButton.isEnabled = !Calendar.current.isDateInToday(currentDate)
    }
}

