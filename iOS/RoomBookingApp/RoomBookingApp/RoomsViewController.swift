//
//  ViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class RoomsViewController: UIViewController {

    let roomsTableView = UITableView()
    
//    private var networkManager = NetworkManager.shared
    
    let headers = ["Lection halls", "Conference halls", "Game rooms"]
    let colors: [[UIColor]] = [[.systemGreen, .systemBlue], [.systemPurple], [.systemGray]]
    
//    var genres
//    var sectionMovies:  = []
    
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
        colors[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell") as! RoomCell
        cell.backgroundColor = colors[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        headers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headers[section]
    }
    
}

//extension RoomsViewController {
//    
//    private func loadGenres() {
//        networkManager.loadGenres { [weak self] genres in
//            guard let self = self else { return }
//            self.genres = genres
//        }
//    }
//    
//    private func loadMovies() {
//        networkManager.loadTodayMovies { [weak self] movies in
//            self?.sectionMovies.append(movies)
//        }
//        networkManager.loadSoonMovies { [weak self] movies in
//            self?.sectionMovies.append(movies)
//        }
//        networkManager.loadTrendingMovies { [weak self] movies in
//            self?.sectionMovies.append(movies)
//        }
//    }
//}
