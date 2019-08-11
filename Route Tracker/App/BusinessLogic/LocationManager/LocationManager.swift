//
//  LocationManager.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 11/08/2019.
//

import Foundation
import CoreLocation
import RxSwift

final class LocationManager: NSObject {
	static let instance = LocationManager()
	
	private override init() {
		super.init()
		configureLocationManager()
	}
	
	internal let locationManager = CLLocationManager()
	internal let location: Variable<CLLocation?> = Variable(nil)
	
	internal func startUpdatingLocation() {
		locationManager.startUpdatingLocation()
	}
	
	internal func stopUpdatingLocation() {
		locationManager.stopUpdatingLocation()
	}
	
	internal func requestLocation() {
		locationManager.requestLocation()
	}
	
	private func configureLocationManager() {
		locationManager.delegate = self
		locationManager.allowsBackgroundLocationUpdates = true
		locationManager.pausesLocationUpdatesAutomatically = false
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.startMonitoringSignificantLocationChanges()
		locationManager.requestAlwaysAuthorization()
	}
	
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		self.location.value = locations.last
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
}
