//
//  MoreViewController.swift
//  Kanto
//
//  Created by Сергей on 26.09.2021.
//

import UIKit

class MoreViewController: UIViewController {

	var infoLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setup()
    }
    
	//MARK: - Private functions
	
	private func setup() {
		self.view.backgroundColor = .white
		
		infoLabel = UILabel()
		infoLabel.lineBreakMode = .byWordWrapping
		infoLabel.numberOfLines = 0
		infoLabel.text = "Additional functions are not available.\n(Services are under development)"
		infoLabel.textAlignment = .left
		
		infoLabel.translatesAutoresizingMaskIntoConstraints = false
		
		self.view.addSubview(infoLabel)
		
		infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		infoLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
	}

}
