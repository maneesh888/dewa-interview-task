//
//  MapDetailsViewController.swift
//  Composition-Deffable-DEWA
//
//  Created by Maneesh M on 18/02/23.
//

import UIKit
import MapKit
import SDWebImage

class MapDetailsViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var coordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var landMarkLabel: UILabel!
    
    @IBOutlet weak var officeNumberLabel: UILabel!
    @IBOutlet weak var callCenterNumberLabel: UILabel!
    @IBOutlet weak var emergencyNumberLabel: UILabel!
    @IBOutlet weak var workingHoursLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!

    
    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    var item:Listable!{
        didSet {
            coordinate = item.location?.coordinate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the map view
        
        setupMap()
        setData()
        
    }
    
    func setData() {
        //TODO: - Should improve with usage of proper protocol for Detaisl screen
        if let customerService = item as? CustomerServiceItem {
            
            title = "Customer Service"
            titleLabel.isHidden = customerService.titleValue.isEmpty
            
            addressLabel.isHidden = customerService.address.isNilOrEmpty
            landMarkLabel.isHidden = customerService.landmark.isNilOrEmpty
            
            officeNumberLabel.isHidden = customerService.officenumber.isNilOrEmpty
            callCenterNumberLabel.isHidden = customerService.callcenternumber.isNilOrEmpty
            emergencyNumberLabel.isHidden = customerService.emergencynumber.isNilOrEmpty
            workingHoursLabel.isHidden = customerService.workinghours.isNilOrEmpty
            websiteLabel.isHidden = customerService.website.isNilOrEmpty
            
            
            titleLabel.text = customerService.titleValue
            title = customerService.code
            addressLabel.text = customerService.address
            landMarkLabel.text = customerService.landmark
            
            officeNumberLabel.text = "Office: \(customerService.officenumber ?? "-")"
            callCenterNumberLabel.text = "Call Center: \(customerService.callcenternumber ?? "-")"
            emergencyNumberLabel.text = "Emergency No: \(customerService.callcenternumber ?? "-")"
            workingHoursLabel.text = "Working Hours: \(customerService.workinghours ?? "-")"
            websiteLabel.text = customerService.website
            
            if let url = URL(string: customerService.image ?? "") {
                imageView.sd_setImage(with: url)
            }
            
            
            
        }else if let cordinateItem = item as? CordinateItem {
            
            title = "Location"
            
            titleLabel.text = cordinateItem.titleValue
           
            imageView.isHidden = true
            
            addressLabel.isHidden = true
            landMarkLabel.isHidden = true
            
            officeNumberLabel.isHidden = true
            callCenterNumberLabel.isHidden = true
            emergencyNumberLabel.isHidden = true
            workingHoursLabel.isHidden = true
            websiteLabel.isHidden = true
            
        }
    }
    
    func setupMap() {
        
        mapView.delegate = self
        
        view.addSubview(mapView)
        
        guard let coordinate = coordinate else {
            let dubaiLocation = CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: dubaiLocation, span: span)
            
            mapView.setRegion(region, animated: true)
            return
        }
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

extension String? {
    var isNilOrEmpty: Bool {
        return self == nil || self == ""
    }
}
