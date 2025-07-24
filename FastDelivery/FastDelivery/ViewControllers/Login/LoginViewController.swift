//
//  LoginViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 08/07/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let enterButton = UIButton(type: .system)
    let bottomLabel = UILabel()
    let registerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

// MARK: - Extensions
extension LoginViewController {
    private func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Bem-vindo de volta 👋"
        titleLabel.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Faça login para continuar"
        subtitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
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
        
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.setTitle("Entrar", for: .normal)
        enterButton.backgroundColor = UIColor(named: "blueColor")
        enterButton.layer.cornerRadius = 20
        enterButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        enterButton.tintColor = .white
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.text = "Não tem uma conta?"
        bottomLabel.font = UIFont.systemFont(ofSize: 18)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Cadastrar-se", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        registerButton.addTarget(self, action: #selector(showRegister), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(enterButton)
        view.addSubview(bottomLabel)
        view.addSubview(registerButton)
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2)
        ])
        
        // subtitleLabel
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        // emailTextField
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 6),
            emailTextField.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
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
            enterButton.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 3),
            enterButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            enterButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // bottomLabel
        NSLayoutConstraint.activate([
            bottomLabel.bottomAnchor.constraint(equalTo: registerButton.topAnchor),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // registerButton
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc func showRegister() {
        let registerVC = RegisterViewController()
        
        navigationController?.pushViewController(registerVC, animated: true)
    }
}
