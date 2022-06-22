//
//  DetailsViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    let timeSlotsTableView = UITableView()
    
    let arr: [String] = ["10:00 - 11:30", "13:00 - 14:00"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
        makeConstraints()
    }
    
    func configureTableView() {
        timeSlotsTableView.delegate = self
        timeSlotsTableView.dataSource = self
        timeSlotsTableView.register(TimeCell.self, forCellReuseIdentifier: "timeCell")
    }
    
    func makeConstraints() {
        view.addSubview(timeSlotsTableView)
        timeSlotsTableView.translatesAutoresizingMaskIntoConstraints = false
        timeSlotsTableView.frame = view.bounds
    }
    
}

// MARK: - TableView Delegates

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell") as! TimeCell
        cell.textLabel?.text = arr[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
    
}
