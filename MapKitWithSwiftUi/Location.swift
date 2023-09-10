//
//  Location.swift
//  MapKitWithSwiftUi
//
//  Created by Gaurav Tak on 11/09/23.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Hashable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
    }
    
    var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }
       
    
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
