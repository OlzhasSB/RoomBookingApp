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
    
    var labelText: String!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImageView()
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignParameters(number: Int, image: UIImage) {
        descriptionLabel.text = "Кабинет: \(number)"
        roomImageView.image = image
    }
    
    func configureImageView() {
        contentView.addSubview(roomImageView)
        roomImageView.translatesAutoresizingMaskIntoConstraints = false
        roomImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        roomImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        roomImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        roomImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        roomImageView.contentMode = .scaleAspectFit
    }
    
    func configureLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: roomImageView.trailingAnchor, constant: 20).isActive = true
    }
}
