//
//  SimpleMapView.swift
//  MapKitWithSwiftUi
//
//  Created by Gaurav Tak on 11/09/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct SimpleMapView: View {
    var body: some View {
        MapView()
    }
}

struct MapView: UIViewRepresentable {
    // Location Manager object to request location updates from the core API
    var locationManager = CLLocationManager()
    // Setup function for the representable
    func setup() {
        // Set the location manager properties
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    // Function to configure the representable view
    func makeUIView(context: Context) -> MKMapView {
        // Call the setup function
        setup()
        // Initialize the representable view
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // Return the representable view
        return mapView
    }
    // Function to update the representable view
    func updateUIView(_ uiView: MKMapView, context: Context) {
      // Do nothing
    }
}

struct SimpleMapView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleMapView()
    }
}

