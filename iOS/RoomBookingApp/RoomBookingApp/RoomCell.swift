//
//  RoomCell.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class RoomCell: UITableViewCell {

    let roomImageView = UIImageView()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImageView()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        contentView.addSubview(roomImageView)
        roomImageView.translatesAutoresizingMaskIntoConstraints = false
        roomImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        roomImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        roomImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        roomImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        roomImageView.image = UIImage(named: "male")
    }
    
    func configureLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        descriptionLabel.text = "Room 304"
    }
    
}
