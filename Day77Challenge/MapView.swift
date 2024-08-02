//
//  MapView.swift
//  Day77Challenge
//
//  Created by Ayrton Parkinson on 2024/08/02.
//

import CoreLocation
import MapKit
import SwiftUI

struct MapView: View {
    var location: CLLocationCoordinate2D?
    
    var body: some View {
        if let coordinates = location {
            let coordinates2d = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
            let position = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: coordinates2d,
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                )
            )
            Map(initialPosition: position) {
                Marker("", coordinate: coordinates2d)
            }
            .frame(width: 300, height: 300)
            .cornerRadius(15)
        } else {
            ContentUnavailableView {
                Text("No location found.")
            }
        }
    }
}

#Preview {
    MapView(location: nil)
}
