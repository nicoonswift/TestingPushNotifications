//
//  TheftViewController.swift
//  TestingPushNotifications
//
//  Created by Nicolás García on 03-01-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import UIKit
import MapKit

final class TheftViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var locationCoordinate2D: CLLocationCoordinate2D! {
        didSet {
            let bikePosition = BikePosition(title: "bike", subtitle: "position", coordinate: locationCoordinate2D)
            mapView.addAnnotation(bikePosition)
            
            let regionRadius: CLLocationDistance = 1000
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(locationCoordinate2D,
                                                                      regionRadius, regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    }

}

extension TheftViewController: MKMapViewDelegate {}
