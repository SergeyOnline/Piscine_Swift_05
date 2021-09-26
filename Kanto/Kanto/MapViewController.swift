//
//  MapViewController.swift
//  Kanto
//
//  Created by Сергей on 26.09.2021.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate {
	func changeLocationTo(_ location: CustomLocation)
	func placePinssOnMap(locations: [CustomLocation])
}

class MapViewController: UIViewController {

	var mapView: MKMapView!
	var segmentedControl: UISegmentedControl!
	var userPositionButton: UIButton!
	let locationManager = CLLocationManager()
	var currentlocation = CLLocation()
	var delegate: ListViewController?
	private var pinsDescriptions: [String: String] = [:]
	private var locations: [CustomLocation] = []
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		mapView.frame = self.view.frame
	}
	
	//MARK: - Actions
	
	@objc func userPositionButtonAction(_ sender: UIButton) {
		
		let currentLocation = CustomLocation(title: "My Location",
											 latitude: currentlocation.coordinate.latitude,
											 longitude: currentlocation.coordinate.longitude,
											 distance: 1500)
		mapView.region = currentLocation.region
	}
	
	//MARK: - Private functions
	
	private func setup() {
		
		self.locationManager.requestAlwaysAuthorization()
		self.locationManager.requestWhenInUseAuthorization()

		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.startUpdatingLocation()
		} else {
			print("No access to geolocation")
		}
		
		mapView = MKMapView(frame: self.view.frame)
		mapView.delegate = self
		mapView.showsUserLocation = true
		self.view.addSubview(mapView)
		
		placePinssOnMap(locations: self.locations)
		
		segmentedControl = UISegmentedControl(items: ["standard", "satellite", "hybrid"])
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		mapView.addSubview(segmentedControl)
		
		segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		segmentedControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
		segmentedControl.backgroundColor = .white.withAlphaComponent(0.7)
		segmentedControl.selectedSegmentIndex = 0
		
		let standartAction = UIAction(title: "standard") { _ in
			self.mapView.mapType = .standard
		}
		
		let satelliteAction = UIAction(title: "satellite") { _ in
			self.mapView.mapType = .satellite
		}
		
		let hybridAction = UIAction(title: "hybrid") { _ in
			self.mapView.mapType = .hybrid
		}
		
		segmentedControl.setAction(standartAction, forSegmentAt: 0)
		segmentedControl.setAction(satelliteAction, forSegmentAt: 1)
		segmentedControl.setAction(hybridAction, forSegmentAt: 2)
		
		userPositionButton = UIButton(type: .custom)
		userPositionButton.setImage(UIImage.init(systemName: "location.fill"), for: .normal)
		userPositionButton.translatesAutoresizingMaskIntoConstraints = false
		userPositionButton.addTarget(self, action: #selector(userPositionButtonAction), for: .touchUpInside)
		mapView.addSubview(userPositionButton)
		
		userPositionButton.widthAnchor.constraint(equalTo: segmentedControl.heightAnchor).isActive = true
		userPositionButton.heightAnchor.constraint(equalTo: segmentedControl.heightAnchor).isActive = true
		userPositionButton.leftAnchor.constraint(equalTo: segmentedControl.rightAnchor).isActive = true
		userPositionButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor).isActive = true
	}

}

extension MapViewController: MKMapViewDelegate {

	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
		guard let pin = annotation as? MKPointAnnotation else { return nil }
		for location in self.locations {
			if location.title == pin.title {
				annotationView.markerTintColor = location.pinColor
				break
			}
		}
		return annotationView
	}
	
	
	func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
		
		if let pin = view.annotation as? MKPointAnnotation {
			guard let description = pinsDescriptions[pin.title ?? ""] else { return }
			pin.subtitle = description
		}
	}

	func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
		if let pin = view.annotation as? MKPointAnnotation {
			pin.subtitle = ""
		}
	}

}

extension MapViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		currentlocation = locations.last! as CLLocation
	}
}

extension MapViewController: MapViewControllerDelegate {
	
	func placePinssOnMap(locations: [CustomLocation]) {
		self.locations += locations
		for location in self.locations {
			let pin = MKPointAnnotation()
			pin.coordinate =  location.center
			pin.title = location.title
			pinsDescriptions[location.title] = location.description
			mapView.addAnnotation(pin)
		}
		if !locations.isEmpty {
			mapView.region = locations[0].region
		} else {
			let center = CLLocationCoordinate2D(latitude: 48.89645180535319, longitude: 2.318608286870089)
			let distanse: CLLocationDistance = 500
			mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: distanse, longitudinalMeters: distanse)
		}
	}
	
	func changeLocationTo(_ location: CustomLocation) {
		mapView.region = location.region
	}
}
