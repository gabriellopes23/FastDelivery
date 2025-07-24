//
//  ProfileViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 18/07/25.
//

import UIKit

class ProfileViewController: UIViewController {

    let profilePreview = ProfilePreview()
    let configPreview = ConfigsPreview()
    let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        let titleFont = UIFont.systemFont(ofSize: 32, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: UIColor.label
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        setup()
        layout()
    }
}

// MARK: - Extension
extension ProfileViewController {
    private func setup() {
        profilePreview.translatesAutoresizingMaskIntoConstraints = false
        configPreview.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.plain()
        config.titleAlignment = .leading
        config.title = "Sair"
        config.baseForegroundColor = .systemRed
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.configuration = config
        logoutButton.backgroundColor = .white
        logoutButton.layer.cornerRadius = 12
        logoutButton.layer.shadowColor = UIColor.black.cgColor
        logoutButton.layer.shadowRadius = 6
        logoutButton.layer.shadowOpacity = 0.1
        logoutButton.contentHorizontalAlignment = .left
    }
    
    private func layout() {
        view.addSubview(profilePreview)
        view.addSubview(configPreview)
        view.addSubview(logoutButton)
        
        let height = view.frame.height
        
        NSLayoutConstraint.activate([
            profilePreview.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            profilePreview.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: profilePreview.trailingAnchor, multiplier: 2),
            
            configPreview.topAnchor.constraint(equalToSystemSpacingBelow: profilePreview.bottomAnchor, multiplier: 2),
            configPreview.leadingAnchor.constraint(equalTo: profilePreview.leadingAnchor),
            configPreview.trailingAnchor.constraint(equalTo: profilePreview.trailingAnchor),
            configPreview.heightAnchor.constraint(equalToConstant: height * 0.3),
            
            logoutButton.topAnchor.constraint(equalToSystemSpacingBelow: configPreview.bottomAnchor, multiplier: 5),
            logoutButton.leadingAnchor.constraint(equalTo: profilePreview.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: profilePreview.trailingAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
