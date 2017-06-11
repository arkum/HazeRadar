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
        // center map
        mapView.delegate = self
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
    
    // Draw regions
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
                
                //addRadiusCircle(location: location)
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PSIAnnotation {
            return PSIAnnotationView(annotation: annotation, reuseIdentifier: "id")
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MKCircle.self){
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.1)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 1
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func addRadiusCircle(location: CLLocationCoordinate2D){
        self.mapView.delegate = self
        let circle = MKCircle(center: location, radius: 1000)
        self.mapView.add(circle)
    }
    
    func centerMapOnLocation() {
        let location = CLLocation(latitude: 1.364598, longitude: 103.807244)
        let regionRadius: CLLocationDistance = 20000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
}
