//
//  AdvancedMapView.swift
//  MapKitWithSwiftUi
//
//  Created by Gaurav Tak on 11/09/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct AdvancedMapView: View {
    var locations = [
        Location(name: "Gateway of India, Mumbai, India", coordinate: CLLocationCoordinate2D(latitude: 18.922064, longitude: 72.834641)),
        Location(name: "Malad West, Mumbai, India", coordinate: CLLocationCoordinate2D(latitude: 19.182755, longitude: 72.840157)),
        Location(name: "Ville Parle, Mumbai, India", coordinate: CLLocationCoordinate2D(latitude: 19.102512, longitude: 72.845367))
        ]
    
    @State var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.0596, longitude: 72.8295), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
  
    var body: some View {
        ZStack  {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapMarker(coordinate: location.coordinate, tint: Color.blue)
            }
        }
    }
}

