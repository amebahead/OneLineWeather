//
//  ViewController.swift
//  OneLineWeatherEx
//
//  Created by Jun soo Song on 15/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var oneLineWeatherView: OneLineWeatherView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        oneLineWeatherView = OneLineWeatherView(frame: self.view.frame)
        self.view.addSubview(oneLineWeatherView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        let location = (manager.location?.coordinate)!
        print("++")
        print("\(location.latitude) ,\(location.longitude)")
        print("++")
        
        let convertLoc = OneLineWeatherUtil.convertPosition(mode: .PosXY, lat_X: location.latitude, lng_Y: location.longitude)
        oneLineWeatherView.getWeatherDust(x: convertLoc.x, y: convertLoc.y, 지역: "부산")
    }
}




















