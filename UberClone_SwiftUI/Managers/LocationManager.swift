//
//  LocationManager.swift
//  UberClone_SwiftUI
//
//  Created by M H on 21/12/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
	private let locationManager = CLLocationManager()
	
	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingHeading()
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard !locations.isEmpty else {return}
		locationManager.stopUpdatingLocation()
	}
}
