//
//  ListTableViewCell.swift
//  Kanto
//
//  Created by Сергей on 26.09.2021.
//

import UIKit

class ListTableViewCell: UITableViewCell {
	
	var titlelabel: UILabel!
	var pinImageView: UIImageView!
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		titlelabel = UILabel()
		titlelabel.translatesAutoresizingMaskIntoConstraints = false
		
		self.addSubview(titlelabel)
		titlelabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 35).isActive = true
		titlelabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		pinImageView = UIImageView()
		pinImageView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(pinImageView)
		
		pinImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		pinImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35).isActive = true
		pinImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
		pinImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
		pinImageView.layer.cornerRadius = 10
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
