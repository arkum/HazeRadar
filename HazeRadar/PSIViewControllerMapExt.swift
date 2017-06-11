//
//  PSIViewControllerMapExt.swift
//  HazeRadar
//
//  Created by Sajid Kalla on 11/6/17.
//  Copyright © 2017 Bytters. All rights reserved.
//

import MapKit

extension PSIViewController: MKMapViewDelegate {
    
    func setupMapView(){
        
        mapView.delegate = self
        
        // center map
        centerMapOnLocation()
    }
    
    func showAnnotations(){
        mapView.removeAnnotations(mapView.annotations)
        addAnnotation(data: self.psiData?.central)
        addAnnotation(data: self.psiData?.north)
        addAnnotation(data: self.psiData?.east)
        addAnnotation(data: self.psiData?.south)
        addAnnotation(data: self.psiData?.west)
    }
    
    func addAnnotation(data: PSIRegion?) {
        if let psiData = data {
            if  let psi = psiData.psi,
                let regionName = psiData.name,
                let lat = psiData.latitude,
                let lon = psiData.longitude
                
            {
                let location = CLLocationCoordinate2D(latitude: lat,longitude: lon)
                let psiAnnotation = PSIAnnotation(psi: psi.stringValue,
                                                  region: regionName.rawValue,
                                                  coordinate: location)
                mapView.addAnnotation(psiAnnotation)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PSIAnnotation {
            return PSIAnnotationView(annotation: annotation, reuseIdentifier: "id")
        }
        return nil
    }
   
    func centerMapOnLocation() {
        let location = CLLocation(latitude: 1.364598, longitude: 103.807244)
        let regionRadius: CLLocationDistance = 20000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
