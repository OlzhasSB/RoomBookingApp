//
//  ViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class RoomsViewController: UIViewController {

    let roomsTableView = UITableView()
    
    let arr: [UIColor] = [.systemGreen, .systemBlue]
    
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
        arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! RoomCell
        cell.backgroundColor = arr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
