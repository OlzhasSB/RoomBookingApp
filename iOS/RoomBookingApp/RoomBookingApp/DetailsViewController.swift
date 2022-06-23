//
//  DetailsViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    let roomLabel = UILabel()
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
    
    var reservations: [Request] = [] {
        didSet {
            timeSlotsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        loadReservations()
        
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
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
//        toggleViews()
        
        guard let roomNumber = roomNumber else { return }
        guard let duration = durationTextField.text, durationTextField.hasText else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let timefrom = dateFormatter.string(from: datePicker.date)
        let withInterval = datePicker.date.addingTimeInterval(Double(duration)!*60)
        let timeto = dateFormatter.string(from: withInterval)

        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else { return }
        
        networkManager.postReservation(path: roomNumber, token: token, timefrom: timefrom, timeto: timeto) { result in
            switch result {
            case .success( _):
                let dialogMessage = UIAlertController(title: "Успешно!", message: "", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Закрыть", style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            case .failure( _):
                let dialogMessage = UIAlertController(title: "Внимание!", message: "Клэш по времени", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
        
//        loadRequests()
    }
    
    func toggleViews() {
        timeSlotsTableView.isHidden.toggle()
        fromStackView.isHidden.toggle()
        durationStackView.isHidden.toggle()
        requestButton.isHidden.toggle()
        occupiedLabel.isHidden.toggle()
        roomLabel.isHidden.toggle()
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
        view.addSubview(roomLabel)
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        roomLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        roomLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        roomLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        roomLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        roomLabel.text = "Комната: #\(roomNumber!)"
        
        view.addSubview(occupiedLabel)
        occupiedLabel.translatesAutoresizingMaskIntoConstraints = false
        occupiedLabel.topAnchor.constraint(equalTo: roomLabel.bottomAnchor).isActive = true
        occupiedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        occupiedLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        occupiedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        occupiedLabel.text = "Данные слоты заняты:"
        
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
        reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell") as! TimeCell
        if reservations.count > 0 {
            let from = reservations[indexPath.row].timefrom
            let to = reservations[indexPath.row].timeto
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
    
    private func loadReservations() {
        guard let roomNumber = roomNumber else { return }
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else { return }
        networkManager.getReservations(path: roomNumber, token: token) { (result) in
            switch result {
            case .success(let reservations):
                self.reservations = reservations
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
