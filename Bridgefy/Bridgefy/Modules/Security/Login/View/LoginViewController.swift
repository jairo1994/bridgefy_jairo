//
//  LoginViewController.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 26/09/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    private let actionButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.imagePadding = 10
        config.imagePlacement = .trailing
        config.baseBackgroundColor = Colors.Enfasis.color
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .large)
        
        let button = UIButton()
        button.configuration = config
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(showTabBar), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        
        return button
    }()
    
    private let userTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "usuario@gmail.com"
        textfield.text = "challenge@bridgefy.me"
        textfield.font = UIFont.systemFont(ofSize: 20)
        
        return textfield
    }()
    
    private let passTextField: UITextField = {
        let textfield = UITextField()
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Contraseña"
        textfield.text = "P@$$w0rD!"
        textfield.font = UIFont.systemFont(ofSize: 20)
        
        return textfield
    }()
    
    private let stackText: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 32
        
        return stack
    }()
    
    private let icon: UIButton = {
        let icon = UIButton(type: .system)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.setImage(UIImage(named: "Icon"), for: .normal)
        icon.tintColor = Colors.Enfasis.color
        
        return icon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupConfiguration(){
        view.addSubview(actionButton)
        stackText.addArrangedSubview(userTextField)
        stackText.addArrangedSubview(passTextField)
        view.addSubview(stackText)
        view.addSubview(icon)
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            actionButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            
            stackText.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -42),
            stackText.leadingAnchor.constraint(equalTo: actionButton.leadingAnchor),
            stackText.trailingAnchor.constraint(equalTo: actionButton.trailingAnchor),
            
            icon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 172),
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            icon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
    }
    
    @objc func showTabBar(){
        if let user = userTextField.text, let pass = passTextField.text, user == "challenge@bridgefy.me", pass == "P@$$w0rD!" {
            self.navigationController?.viewControllers = [TabBarViewController()]
        }else{
            Messages.showMessage(theme: .error, title: "Ups", body: "User or password are incorrect")
        }
        
        
    }
}
