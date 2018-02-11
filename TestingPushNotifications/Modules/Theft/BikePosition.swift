//
//  BikePosition.swift
//  TestingPushNotifications
//
//  Created by Nicolás García on 11-02-18.
//  Copyright © 2018 Nicolas Garcia. All rights reserved.
//

import Foundation
import MapKit

final class BikePosition: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }
    
}
