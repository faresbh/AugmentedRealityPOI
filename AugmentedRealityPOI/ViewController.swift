//
//  ViewController.swift
//  AugmentedRealityPOI
//
//  Created by Fares Ben Hamouda on 09/11/2016.
//  Copyright © 2016 Fares Ben Hamouda. All rights reserved.
//

import UIKit
import CoreLocation
import HDAugmentedReality


class ViewController: UIViewController , ARDataSource , CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var myLocation : CLLocation?
    let arViewController = ARViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
           
           
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
    }

    
    /// Creates random annotations around predefined center point and presents ARViewController modally
    func showARViewController()
    {
        // Check if device has hardware needed for augmented reality
        let result = ARViewController.createCaptureSession()
        if result.error != nil
        {
            let message = result.error?.userInfo["description"] as? String
            let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        // Create random annotations around center point    //@TODO
        //FIXME: set your initial position here, this is used to generate random POIs
        let lat = 45.554833
        let lon = 18.695433
        let delta = 0.05
        let count = 50
        let dummyAnnotations = self.getDummyAnnotations(centerLatitude: lat, centerLongitude: lon, delta: delta, count: count)
        
        // Present ARViewController
        arViewController.dataSource = self
        arViewController.maxDistance = 0
        arViewController.maxVisibleAnnotations = 100
        arViewController.maxVerticalLevel = 5
        arViewController.headingSmoothingFactor = 0.05
        arViewController.trackingManager.userDistanceFilter = 25
        arViewController.trackingManager.reloadDistanceFilter = 75
        arViewController.setAnnotations(dummyAnnotations)
        arViewController.uiOptions.debugEnabled = true
        arViewController.uiOptions.closeButtonEnabled = true
        self.present(arViewController, animated: true, completion: nil)
    }
    
    /// This method is called by ARViewController, make sure to set dataSource property.
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView
    {
        // Annotation views should be lightweight views, try to avoid xibs and autolayout all together.
        let annotationView = TestAnnotationView()
        annotationView.frame = CGRect(x: 0,y: 0,width: 150,height: 50)
        return annotationView;
    }
    
    fileprivate func getDummyAnnotations(centerLatitude: Double, centerLongitude: Double, delta: Double, count: Int) -> Array<ARAnnotation>
    {
        var annotations: [ARAnnotation] = []
        
        srand48(3)
        for i in stride(from: 0, to: count, by: 1)
        {
            let annotation = ARAnnotation()
            annotation.location = self.getRandomLocation(centerLatitude: centerLatitude, centerLongitude: centerLongitude, delta: delta)
            annotation.title = "POI \(i)"
            annotations.append(annotation)
        }
        return annotations
    }
    
    fileprivate func getRandomLocation(centerLatitude: Double, centerLongitude: Double, delta: Double) -> CLLocation
    {
        var lat = centerLatitude
        var lon = centerLongitude
        
        let latDelta = -(delta / 2) + drand48() * delta
        let lonDelta = -(delta / 2) + drand48() * delta
        lat = lat + latDelta
        lon = lon + lonDelta
        return CLLocation(latitude: lat, longitude: lon)
    }
    
    @IBAction func buttonTap(_ sender: AnyObject)
    {
        showARViewController()
    }
    
    

    

}

