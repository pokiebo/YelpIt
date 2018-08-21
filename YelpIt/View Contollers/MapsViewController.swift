//
//  MapsViewController.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 8/21/18.
//  Copyright © 2018 Sudipta Bhowmik. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    //var rests : [Restaurant]?
    var locationManager : CLLocationManager!
    
    //MARK - Properties
    //===================
   
    var restaurants: [Restaurant]? {
        didSet {
            if let r = oldValue {
                self.mapView.removeAnnotations(r)
            }
            print("In mapview ")
            if let rests = restaurants {
                mapView.addAnnotations(rests)
            }
            
        }
    }
    
    var mapRestaurants : [Restaurant]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        //Setup Location on Map
        setupLocation()
        //This will trigget mapView.addAnnotations()
        self.restaurants = mapRestaurants
    }

    func setupLocation() {
        //Setting initial location to san mateo - this will be the center, so restaurants in SF will appear toward top of mapview
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 37.785771, longitude: -122.406165)
        centerMapOnLocation(location: initialLocation)
        /*locationManager = CLLocationManager()
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         locationManager.distanceFilter = 200
         locationManager.requestWhenInUseAuthorization()*/
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - MapView Delegate functions
    //==============================
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var view : MKPinAnnotationView
        guard let annotation = annotation as? Restaurant else {return nil}
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? MKPinAnnotationView {
            view = dequeuedView
        }else { //make a new view
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
        }
        
        for v in view.subviews {
            v.removeFromSuperview()
        }
        
        let labview = UILabel(frame: CGRect(x: -15, y:15, width: 100, height: 30))
        //labview.sizeToFit()
        labview.backgroundColor = UIColor.clear
        labview.text = annotation.title
        //labview.font = labview.font.withSize(12)
        labview.font = UIFont.boldSystemFont(ofSize: 12.0)
        view.addSubview(labview)
        return view
    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
