//
//  AuthorizationViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {

    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeConstraints()
    }
    
    @objc func loginButtonPressed() {
        let roomsVC = RoomsViewController()
        navigationController?.pushViewController(roomsVC, animated: true)
    }
    
    func makeConstraints() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        nameTextField.textAlignment = .left
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.cornerRadius = 5
        nameTextField.layer.borderColor = UIColor.systemGray5.cgColor
        nameTextField.setLeftPaddingPoints(10)
        nameTextField.becomeFirstResponder()
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.placeholder = "Name"
        
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        passwordTextField.textAlignment = .left
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderColor = UIColor.systemGray5.cgColor
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.becomeFirstResponder()
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.placeholder = "Password"
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemGreen
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
