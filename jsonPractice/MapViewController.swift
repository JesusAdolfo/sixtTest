//
//  MapViewController.swift
//  sixtTest
//
//  Created by Jesus Adolfo on 4/7/17.
//  Copyright © 2017 adolfo. All rights reserved.
//

import UIKit
import MapKit
import TRON
import Kingfisher

class MapViewController: UIViewController, MKMapViewDelegate {

    var cars = [Car]()
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        getCarInfo()

    }
    
    func configureMap()  {
        mapView.delegate                     = self
        mapView.showsUserLocation            = true
        let homeLocation                     = CLLocation(latitude: 48.1351, longitude: 11.5820)
        let regionRadius: CLLocationDistance = 5000
        let coordinateRegion                 = MKCoordinateRegionMakeWithDistance(homeLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)

    }
    
    func addCoordinates() {
        
        // Add annotation
        let annotations = cars.map { car -> MKAnnotation in
            let annotation        = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(car.latitude), longitude: CLLocationDegrees(car.longitude) )
            annotation.title      = car.name
            annotation.subtitle   = "\(car.make)  (\(car.licensePlate))"
            return annotation
        }
        
         mapView.addAnnotations(annotations)

    }
    
    func getCarInfo()  {
        Service.sharedInstance.fetchCarsFeed { (carsDataSource, err) in
            if let _ = err {
                return
            }
            self.cars = (carsDataSource?.cars)!
            self.addCoordinates()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "carPin"
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as?
        MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.backgroundColor = UIColor(red: 74/255, green: 87/255, blue: 108/255, alpha: 1.0)
        leftIconView.image = #imageLiteral(resourceName: "ic_car")
        

        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.pinTintColor = .orange
        return annotationView
    }
    

}

