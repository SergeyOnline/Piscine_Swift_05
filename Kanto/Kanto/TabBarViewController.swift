//
//  TabBarViewController.swift
//  Kanto
//
//  Created by Сергей on 26.09.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		let mapVC = MapViewController()
		mapVC.tabBarItem.title = "Map"
		mapVC.tabBarItem.image = UIImage.init(systemName: "map")
		
		let listVC = ListViewController()
		listVC.tabBarItem.title = "List"
		listVC.delegate = mapVC
		listVC.tabBarItem.image = UIImage.init(systemName: "list.dash")
		
		let moreVC = MoreViewController()
		moreVC.tabBarItem.title = "More"
		moreVC.tabBarItem.image = UIImage.init(systemName: "ellipsis")
		
		self.tabBar.backgroundColor = .systemGray6
		self.setViewControllers([mapVC, listVC, moreVC], animated: false)
		self.selectedIndex = 1
		self.view.backgroundColor = .lightGray
    }
    
}
