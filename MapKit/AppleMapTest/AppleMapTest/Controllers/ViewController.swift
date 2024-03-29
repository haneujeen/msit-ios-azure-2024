//
//  ViewController.swift
//  AppleMapTest
//
//  Created by 한유진 on 3/29/24.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController {
    let coordinate =  (-16.637, -41.365)
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let location = CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
//        let pin = MKPointAnnotation()
//        pin.coordinate = location
//        pin.title = "MyPin"
//        pin.subtitle = "\(coordinate.0), \(coordinate.1)"
//        mapView.addAnnotation(pin)
        
        let annotation = MyAnnotation(coordinate: location, title: "MyPin", subtitle: "\(coordinate.0), \(coordinate.1)", mapURL: "https://www.apple.com/maps/", thumbnail: "icybay")
        mapView.addAnnotation(annotation)
        mapView.delegate = self
    }

    @IBAction func changeMapTypeAction(_ sender: Any) {
        guard let segment = sender as? UISegmentedControl else { return }
        mapView.preferredConfiguration = switch segment.selectedSegmentIndex {
        case 1: MKImageryMapConfiguration()
        case 2: MKHybridMapConfiguration()
        default: MKStandardMapConfiguration()
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MyAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView?.canShowCallout = true
            let imageView = UIImageView(image: UIImage(named: annotation.thumbnail))
            imageView.frame.size = CGSize(width: 60, height: 40)
            annotationView?.leftCalloutAccessoryView = imageView
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) { // VC (accessory - controller)
        guard let annotation = view.annotation as? MyAnnotation else { return }
        guard let controller = self.storyboard?.instantiateViewController(identifier: "web") as? WebViewController else { return }
        
        controller.mapURL = annotation.mapURL
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
