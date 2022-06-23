//
//  DetailsViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    let occupiedLabel = UILabel()
    let timeSlotsTableView = UITableView()
    let datePicker = UIDatePicker()
    let durationTextField = UITextField()
    let startLabel = UILabel()
    let durationLabel = UILabel()
    let fromStackView = UIStackView()
    let durationStackView = UIStackView()
    let minLabel = UILabel()
    let requestButton = UIButton()
    
    var roomNumber: Int?
    private var networkManager = NetworkManager.shared
    
    var requests: [Request] = [] {
        didSet {
            timeSlotsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        loadRequests()
        
        configureTableView()
        configureDatePicker()
        configureStackViews()
        makeConstraints()
    }
    
    @objc func handleAdd() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleClose))
        toggleViews()
    }
    
    @objc func handleClose() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        toggleViews()
    }
    
    @objc func requestButtonPressed() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        toggleViews()
        
        guard let roomNumber = roomNumber else { return }
        guard let duration = durationTextField.text, durationTextField.hasText else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let timefrom = dateFormatter.string(from: datePicker.date)
        let withInterval = datePicker.date.addingTimeInterval(Double(duration)!*60)
        let timeto = dateFormatter.string(from: withInterval)

        networkManager.makePOSTRequest(path: roomNumber, timefrom: timefrom, timeto: timeto)
        
//        loadRequests()
    }
    
    func toggleViews() {
        timeSlotsTableView.isHidden.toggle()
        fromStackView.isHidden.toggle()
        durationStackView.isHidden.toggle()
        requestButton.isHidden.toggle()
        occupiedLabel.isHidden.toggle()
    }
    
    func convertToDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: stringDate) else { return ""}
        return date.formatted(date: .numeric, time: .shortened)
    }
    
    func configureDatePicker() {
//        datePicker.timeZone = NSTimeZone.local
//        datePicker.backgroundColor = UIColor.white
//        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    func configureStackViews() {
        fromStackView.axis = .horizontal
        fromStackView.alignment = .center
        fromStackView.distribution = .equalSpacing
        fromStackView.spacing = 15
        fromStackView.addArrangedSubview(startLabel)
        fromStackView.addArrangedSubview(datePicker)
        
        durationStackView.axis = .horizontal
        durationStackView.alignment = .center
        durationStackView.distribution = .equalSpacing
        durationStackView.spacing = 15
        durationStackView.addArrangedSubview(durationLabel)
        durationStackView.addArrangedSubview(durationTextField)
        durationStackView.addArrangedSubview(minLabel)
    }
    
    func configureTableView() {
        timeSlotsTableView.delegate = self
        timeSlotsTableView.dataSource = self
        timeSlotsTableView.register(TimeCell.self, forCellReuseIdentifier: "timeCell")
    }
    
    func makeConstraints() {
        view.addSubview(occupiedLabel)
        occupiedLabel.translatesAutoresizingMaskIntoConstraints = false
        occupiedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        occupiedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        occupiedLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        occupiedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        occupiedLabel.text = "These time slots are occupied:"
        
        view.addSubview(timeSlotsTableView)
        timeSlotsTableView.translatesAutoresizingMaskIntoConstraints = false
        timeSlotsTableView.frame = view.bounds
        timeSlotsTableView.topAnchor.constraint(equalTo: occupiedLabel.bottomAnchor).isActive = true
        timeSlotsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        timeSlotsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        timeSlotsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        timeSlotsTableView.layer.borderColor = UIColor.systemGray3.cgColor
        timeSlotsTableView.layer.borderWidth = 0.8
        
        view.addSubview(fromStackView)
        fromStackView.translatesAutoresizingMaskIntoConstraints = false
        fromStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fromStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        startLabel.text = "Начало:"
        fromStackView.isHidden = true
        
        view.addSubview(durationStackView)
        durationStackView.translatesAutoresizingMaskIntoConstraints = false
        durationStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        durationStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        durationStackView.isHidden = true
        
        durationTextField.translatesAutoresizingMaskIntoConstraints = false
        durationTextField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        durationTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        durationTextField.textAlignment = .left
        durationTextField.layer.borderWidth = 2
        durationTextField.layer.cornerRadius = 5
        durationTextField.layer.borderColor = UIColor.systemGray5.cgColor
        durationTextField.setLeftPaddingPoints(10)
        durationTextField.becomeFirstResponder()
        durationTextField.placeholder = "0"
        
        durationLabel.text = "Длительность:"
        minLabel.text = "минут"
        
        view.addSubview(requestButton)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        requestButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        requestButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        requestButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        requestButton.layer.cornerRadius = 5
        requestButton.setTitle("Сделать запрос", for: .normal)
        requestButton.backgroundColor = .systemGreen
        requestButton.addTarget(self, action: #selector(requestButtonPressed), for: .touchUpInside)
        requestButton.isHidden = true
    }
    
}

// MARK: - TableView Delegates

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell") as! TimeCell
        if requests.count > 0 {
            let from = requests[indexPath.row].timefrom
            let to = requests[indexPath.row].timeto
            cell.textLabel?.text = "\(convertToDate(stringDate: from)) - \(convertToDate(stringDate: to))"
        }
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        return cell
    }
    
}

// MARK: - Network Request

extension DetailsViewController {
    
    private func loadRequests() {
        guard let roomNumber = roomNumber else { return }
        networkManager.loadRequests(path: "\(roomNumber)") { [weak self] requests in
            guard let self = self else { return }
            self.requests = requests
        }
    }

}
