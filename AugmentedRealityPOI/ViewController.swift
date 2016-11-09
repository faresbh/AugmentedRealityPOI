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

class ViewController: UIViewController , ARDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Asks the data source to provide annotation view for annotation. Annotation view must be subclass of ARAnnotationView.
    public func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        
        
    }
    

}

