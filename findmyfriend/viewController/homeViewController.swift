//
//  homeViewController.swift
//  findmyfriend
//
//  Created by BIG on 10/11/2563 BE.
//

import UIKit
import MapKit
import FloatingPanel
import CoreLocation

class homeViewController: UIViewController, FloatingPanelControllerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate let locationManager: CLLocationManager = {
       let manager = CLLocationManager()
       manager.requestWhenInUseAuthorization()
       return manager
    }()
    @IBOutlet weak var navigationTab: UITabBar!
         
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
        let fpc = FloatingPanelController()
        fpc.delegate = self
        
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpc_controller") as? contentViewController else {
            return
        }
        fpc.set(contentViewController: contentVC)
        
        fpc.addPanel(toParent: self)
        
    }
    func setUpMapView() {
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        currentLocation()
     }
    func currentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 11.0, *) {
           locationManager.showsBackgroundLocationIndicator = true
        } else {
           // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
     }

}
extension homeViewController: CLLocationManagerDelegate {
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
        locationManager.stopUpdatingLocation()
     }
     
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
     }
}

