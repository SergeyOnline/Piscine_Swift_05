//
//  ListViewController.swift
//  Kanto
//
//  Created by Сергей on 26.09.2021.
//

import UIKit

class ListViewController: UIViewController {
	
	var tableView: UITableView!
	var delegate: MapViewControllerDelegate?
	
	private let identifier = "Cell"
	private let places: [CustomLocation] = [CustomLocation(title: "42",
														   description: "École trop style",
														   latitude: 48.89645180535319,
														   longitude: 2.318608286870089,
														   color: .blue),
											CustomLocation(title: "Moscow",
														   description: "Moscow, Russia",
														   latitude: 55.75733336640586,
														   longitude: 37.62714974081638,
														   color: .magenta),
											CustomLocation(title: "Kazan",
														   description: "Kazan, Russia",
														   latitude: 55.786542935695785,
														   longitude: 49.12548308993233,
														   color: .cyan),
											CustomLocation(title: "London",
														   description: "London, United Kingdom",
														   latitude: 51.514886463950425,
														   longitude: -0.1290700131576307,
														   color: .brown)]

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView = UITableView(frame: self.view.frame, style: .grouped)
		tableView.register(ListTableViewCell.self, forCellReuseIdentifier: identifier)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = .white
		self.view.addSubview(tableView)
		
		delegate?.placePinssOnMap(locations: places)
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tableView.frame = self.view.frame
	}
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		places.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ListTableViewCell
		
		cell.titlelabel.text = places[indexPath.row].title
		cell.pinImageView.backgroundColor = places[indexPath.row].pinColor
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.changeLocationTo(places[indexPath.row])
		self.tabBarController?.selectedIndex = 0
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
}
