//
//  MapDetailsViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 18/02/23.
//

import UIKit
import MapKit

class MapDetailsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var coordinate: CLLocationCoordinate2D?
    
    var item:Listable!{
        didSet {
            coordinate = item.location?.coordinate ?? CoreLocationManager.shared.currentLocation.value?.coordinate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the map view
        self.title = item.titleValue
        
        setupMap()
        
        
        
    }
    
    func setupMap() {
        
        mapView.delegate = self
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        guard let coordinate = coordinate else {return}
        // Add a marker to the map
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        // Zoom to the marker location
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: - MapView Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "marker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let coordinate = coordinate, control == view.rightCalloutAccessoryView {
            // Open Google Maps to show directions to the marker location
            let urlString = "comgooglemaps://?daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving"
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
