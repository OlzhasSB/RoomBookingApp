//
//  SignUpViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 23.06.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private var networkManager = NetworkManager.shared
    
    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    let retryPasswordTextField = UITextField()
    let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeConstraints()
    }
    
    @objc func saveButtonPressed() {
        
        guard let username = nameTextField.text, nameTextField.hasText else { return }
        
        guard let password = passwordTextField.text, passwordTextField.hasText else { return }
        
        if passwordTextField.text == retryPasswordTextField.text {
            networkManager.register(username: username, password: password) 
        }
        
        
        navigationController?.popViewController(animated: true)
    
    }
    
    func makeConstraints() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        nameTextField.textAlignment = .left
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.cornerRadius = 5
        nameTextField.layer.borderColor = UIColor.systemGray5.cgColor
        nameTextField.setLeftPaddingPoints(10)
        nameTextField.becomeFirstResponder()
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.placeholder = "Имя"
        
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        passwordTextField.textAlignment = .left
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderColor = UIColor.systemGray5.cgColor
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.becomeFirstResponder()
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.placeholder = "Пароль"
        
        view.addSubview(retryPasswordTextField)
        retryPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        retryPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        retryPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70).isActive = true
        retryPasswordTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        retryPasswordTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        retryPasswordTextField.textAlignment = .left
        retryPasswordTextField.layer.borderWidth = 2
        retryPasswordTextField.layer.cornerRadius = 5
        retryPasswordTextField.layer.borderColor = UIColor.systemGray5.cgColor
        retryPasswordTextField.setLeftPaddingPoints(10)
        retryPasswordTextField.becomeFirstResponder()
        retryPasswordTextField.clearButtonMode = .whileEditing
        retryPasswordTextField.placeholder = "Повторите пароль"
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        saveButton.layer.cornerRadius = 5
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .systemCyan
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
}
