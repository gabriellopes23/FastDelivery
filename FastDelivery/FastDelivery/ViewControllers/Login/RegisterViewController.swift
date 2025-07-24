//
//  RegisterViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 08/07/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registerButton = UIButton(type: .system)
    let bottomLabel = UILabel()
    let enterButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

// MARK: - Extensions
extension RegisterViewController {
    private func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Criar conta"
        titleLabel.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        titleLabel.numberOfLines = 0
        
        let paddingName = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.height))
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "E-mail"
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.cornerRadius = 20
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.leftView = paddingName
        nameTextField.leftViewMode = .always
        
        let paddingEmail = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.height))
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "E-mail"
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.leftView = paddingEmail
        emailTextField.leftViewMode = .always
        
        let paddingPassword = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: passwordTextField.frame.height))
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Senha"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.leftView = paddingPassword
        passwordTextField.leftViewMode = .always
        
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Cadastrar", for: .normal)
        registerButton.backgroundColor = UIColor(named: "blueColor")
        registerButton.layer.cornerRadius = 20
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        registerButton.tintColor = .white
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.text = "Já tem conta?"
        bottomLabel.font = UIFont.systemFont(ofSize: 18)
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.setTitle("Entrar", for: .normal)
        enterButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(bottomLabel)
        view.addSubview(enterButton)
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2)
        ])
        
        // emailTextField
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 6),
            nameTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nameTextField.trailingAnchor, multiplier: 2),
            nameTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // emailTextField
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalToSystemSpacingBelow: nameTextField.bottomAnchor, multiplier: 2),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: emailTextField.trailingAnchor, multiplier: 2),
            emailTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // passwordTextField
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalToSystemSpacingBelow: emailTextField.bottomAnchor, multiplier: 2),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // enterButton
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 3),
            registerButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // bottomLabel
        NSLayoutConstraint.activate([
            bottomLabel.bottomAnchor.constraint(equalTo: enterButton.topAnchor),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // registerButton
        NSLayoutConstraint.activate([
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
