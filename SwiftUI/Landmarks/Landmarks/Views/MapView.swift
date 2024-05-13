//
//  MapView.swift
//  Landmarks
//
//  Created by 한유진 on 5/10/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    var body: some View {
        Map(initialPosition: .region(region))
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
    }
}

#Preview {
    MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868))
}
