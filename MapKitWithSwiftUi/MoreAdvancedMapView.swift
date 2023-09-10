//
//  MoreAdvancedMapView.swift
//  MapKitWithSwiftUi
//
//  Created by Gaurav Tak on 11/09/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MoreAdvancedMapView: View {
    public var locations = [
       Location(name: "Swaminarayan Akshardham Temple, New Delhi, Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.6127, longitude: 77.2773)),
       Location(name: "Qutub Minar, Seth Sarai, Mehrauli, New Delhi, Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.5244, longitude: 77.1852)),
       Location(name: "The Red Fort, Lal Qila, Netaji Subhash Marg, Delhi", coordinate: CLLocationCoordinate2D(latitude: 28.656473, longitude: 77.242943))
       ]
    public var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 28.5840, longitude: 77.3344), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            MapViewAsMoreAdvancedView(annotations: getAnnotations(locations: locations), mapRegion: mapRegion).edgesIgnoringSafeArea(.all)
            VStack {
                ForEach(0...locations.count-1, id: \.self) { index in
                    Button {
                        print("location Tapped \(locations[index])")
                        NotificationCenter.default.post(name: .reCenterMapLocation, object: nil, userInfo: [NotificationData.reCenterMapLocationData: locations[index]])
                    } label: {
                        Text(locations[index].name)
                            .foregroundColor(Color.white)
                            .font(.system(size: 18))
                    }
                    .frame(maxWidth: .infinity).padding(.horizontal, 20).frame(height: 60).background(Color.blue).padding(.vertical, 5)
                }
            }.padding(.horizontal, 30)
        }.padding(.bottom, 24)
    }
}

// Function that retrieves annotations
func getAnnotations(locations: [Location]) -> [MKPointAnnotation] {
    // Here we are hardcoding the annotations for illustration purposes only
    var annotations = [MKPointAnnotation]()
    var index = 0
    while index < locations.count {
        let annotation = MKPointAnnotation()
        annotation.title = locations[index].name
        annotation.coordinate = CLLocationCoordinate2D(latitude: locations[index].coordinate.latitude, longitude: locations[index].coordinate.longitude)
        annotations.append(annotation)
        index += 1
    }
    return annotations
}
struct MapViewAsMoreAdvancedView: UIViewRepresentable {
    
    // Location Manager object to request location updates from the core API
    var locationManager = CLLocationManager()
    // Annotations array
    var annotations: [MKPointAnnotation]?
    var mapRegion:  MKCoordinateRegion
    // @State var mapView: MKMapView?
    var mapRegion1: MKCoordinateRegion?
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
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        // Provide annotations if they exists
        if let annotations = annotations {
            mapView.showAnnotations(annotations, animated: true)
        }
        mapView.setRegion(mapRegion, animated: true)
        // Return the representable view
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("updateUIView")
    }
    
    func makeCoordinator() -> MapViewCoordinator {
           MapViewCoordinator(self)
       }
       
       var tapCallback: ((MKAnnotationView) -> ())?    // << this one !!
       
       @inlinable public func onAnnotationTapped(site: @escaping (MKAnnotationView) -> ()) -> some View {
           var newMapView = self
           newMapView.tapCallback = site            // << here !!
           return newMapView
       }
       
       public class MapViewCoordinator: NSObject, MKMapViewDelegate {
           var mapView: MapViewAsMoreAdvancedView
           var mkMapView: MKMapView?
           
           init(_ control: MapViewAsMoreAdvancedView) {
               self.mapView = control
               super.init()
               print("init")
               NotificationCenter.default.addObserver(self, selector: #selector(updateMap), name: .reCenterMapLocation, object: nil)
           }
           
           deinit {
               print("deinit")
               NotificationCenter.default.removeObserver(self, name: .reCenterMapLocation, object: nil)
           }
           
           @objc func updateMap(notification: NSNotification) {
               guard let userInfo = notification.userInfo, let locationData = userInfo[NotificationData.reCenterMapLocationData] else {
                   return
               }
               if let locationDataValue = locationData as? Location  {
                   let mapRegion1 = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationDataValue.coordinate.latitude, longitude: locationDataValue.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                   mkMapView?.setRegion(mapRegion1, animated: true)
               }
           }
           
           public func mapView(_ mkMap: MKMapView, didSelect view: MKAnnotationView) {
               print("tapCallback didSelect \(view.center) \(String(describing: (view.value(forKey: "annotation") as? MKAnnotation)?.coordinate))")
               self.mapView.tapCallback?(view)
           }
           
           func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
               print("mapViewDidChangeVisibleRegion \(mapView.centerCoordinate)")
               print(mapView.centerCoordinate)
           }
           
           func mapView(_ mapView: MKMapView,
                        didUpdate userLocation: MKUserLocation) {
               print("User location\(userLocation.coordinate)")
           }
           
           func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
               print("Map will start loading")
               self.mkMapView = mapView
           }
           
           func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
               print("Map did finish loading")
           }
           
           func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
               print("Map will start locating user")
           }
           
           func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
               if annotation is MKUserLocation
                   {
                       return nil;
                   } else {
                       let pinIdent = "Pin";
                       var pinView: MKAnnotationView?
                       if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent)
                       {
                           dequeuedView.annotation = annotation
                           pinView = dequeuedView
                           print("pinView >>>pinView11")
                       }
                       else
                       {
                           pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
                           pinView?.image = UIImage(named: "map_marker_icon")
                           print("pinView >>>pinView22")
                       }
                       pinView?.canShowCallout = true
                       pinView?.setValue(annotation, forKeyPath: "annotation")

                       return pinView;
                   }
           }
       }
}
