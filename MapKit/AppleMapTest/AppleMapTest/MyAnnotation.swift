//
//  MyAnnotation.swift
//  AppleMapTest
//
//  Created by 한유진 on 3/29/24.
//

import UIKit
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let mapURL: String
    let thumbnail: String
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, mapURL: String, thumbnail: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.mapURL = mapURL
        self.thumbnail = thumbnail
    }
}
