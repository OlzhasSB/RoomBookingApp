//
//  ViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class RoomsViewController: UIViewController {

    let roomsTableView = UITableView()
    let headers = ["Лекционные залы", "Конференц-залы", "Игровой зал"]
    
    let rooms: [[Room]] = [[Room(image: UIImage(named: "lection.jpeg")!, number: 302), Room(image: UIImage(named: "lection.jpeg")!, number: 304), Room(image: UIImage(named: "lection.jpeg")!, number: 404)], [Room(image: UIImage(named: "conference.jpeg")!, number: 303)], [Room(image: UIImage(named: "gaming.jpeg")!, number: 203)]]
    
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
        cell.assignParameters(number: rooms[indexPath.section][indexPath.row].number, image: rooms[indexPath.section][indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.roomNumber = rooms[indexPath.section][indexPath.row].number
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        headers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headers[section]
    }
    
}


