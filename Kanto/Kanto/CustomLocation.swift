//
//  CustomLocation.swift
//  Kanto
//
//  Created by Сергей on 26.09.2021.
//

import Foundation
import MapKit

struct CustomLocation {
	var title: String
	var description: String
	var latitude: CLLocationDegrees
	var longitude: CLLocationDegrees
	var distance: CLLocationDistance
	var pinColor: UIColor

	
	var center: CLLocationCoordinate2D {
		get {
			return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		}
	}
	
	var region: MKCoordinateRegion {
		get {
			return MKCoordinateRegion(center: center, latitudinalMeters: distance, longitudinalMeters: distance)
		}
	}
	
	init(title: String, description: String = "", latitude: CLLocationDegrees, longitude: CLLocationDegrees, distance: CLLocationDistance = CLLocationDistance(10000), color: UIColor = .red) {
		self.title = title
		self.latitude = latitude
		self.longitude = longitude
		self.distance = distance
		self.description = description
		self.pinColor = color
	}
}
