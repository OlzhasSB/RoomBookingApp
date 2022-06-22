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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
    }
    
    @objc func handleAdd() {
    
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 200)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        

        

        let alert = UIAlertController(title: "Make a reservation", message: "", preferredStyle: .alert)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter duration"
        }
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [self] (action: UIAlertAction) in
//            guard let title = alert.textFields?.first else { return }
//            guard let subtitle = alert.textFields?[1] else { return }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "These time slots are occupied:"
    }
    
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

extension DetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    
}
