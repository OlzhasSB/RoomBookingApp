//
//  AuthorizationViewController.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    private var networkManager = NetworkManager.shared
    @Published var isAuthenticated: Bool = false

    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        makeConstraints()
    }
    
    @objc func loginButtonPressed() {
        
        let defaults = UserDefaults.standard
        
        guard let username = nameTextField.text, nameTextField.hasText else {
            
            let dialogMessage = UIAlertController(title: "Внимание!", message: "Введите логин и пароль", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        
        guard let password = passwordTextField.text, passwordTextField.hasText else {
            let dialogMessage = UIAlertController(title: "Внимание!", message: "Введите логин и пароль", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
            return
        }
        
        networkManager.auth(username: username, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue("Bearer \(token)", forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
                let roomsVC = RoomsViewController()
                self.navigationController?.pushViewController(roomsVC, animated: true)
            case .failure( _):
                let dialogMessage = UIAlertController(title: "Внимание!", message: "Данный аккаунт не зарегестрирован", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    @objc func signUpButtonPressed() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
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
        nameTextField.placeholder = "Логин"
        
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
        passwordTextField.placeholder = "Пароль"
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -110).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .systemGreen
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        signUpButton.layer.cornerRadius = 5
        signUpButton.setTitle("Регистрация", for: .normal)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

//func signOut() {
//    let defaults = UserDefaults.standard
//    defaults.removeObject(forKey: "jsonwebtoken")
//    DispatchQueue.main.async {
//        self.isAuthenticated = false
//    }
//}
