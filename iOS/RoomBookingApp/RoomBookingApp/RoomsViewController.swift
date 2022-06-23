//
//  ViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class RoomsViewController: UIViewController {

    let roomsTableView = UITableView()
    let headers = ["Lection halls", "Conference halls", "Game rooms"]
    let rooms: [[Int]] = [[302, 304, 404], [303], [206]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rooms"
        configureRoomsTableView()
        makeConstraints()
    }
    
    func configureRoomsTableView() {
        roomsTableView.delegate = self
        roomsTableView.dataSource = self
        roomsTableView.register(RoomCell.self, forCellReuseIdentifier: "roomCell")
        roomsTableView.rowHeight = 125
    }
    
    func makeConstraints() {
        view.addSubview(roomsTableView)
        roomsTableView.frame = view.bounds
    }
    
}

// MARK: - TableView Delegates

extension RoomsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! RoomCell
        cell.selectionStyle = .none
        cell.assignParameters(number: rooms[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.roomNumber = rooms[indexPath.section][indexPath.row]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        headers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headers[section]
    }
    
}


