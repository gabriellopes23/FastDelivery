//
//  Profile.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 30/08/25.
//

import UIKit

class Profile: UIViewController {
    private var addressView = AddressView()
    private var supportView = SupportView()
    
    private var titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 36, weight: .bold)
        ]
        navigationController?.navigationBar.titleTextAttributes = title
        navigationItem.title = "Minha Conta"
        
        style()
        layout()
    }
}

// MARK: - Extensions
extension Profile {
    private func style() {
        addressView.translatesAutoresizingMaskIntoConstraints = false
    
        
        supportView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(addressView)
        view.addSubview(supportView)
        
        NSLayoutConstraint.activate([
            addressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            addressView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: addressView.trailingAnchor, multiplier: 2),
            
            supportView.topAnchor.constraint(equalToSystemSpacingBelow: addressView.bottomAnchor, multiplier: 2),
            supportView.leadingAnchor.constraint(equalTo: addressView.leadingAnchor),
            supportView.trailingAnchor.constraint(equalTo: addressView.trailingAnchor),
        ])
    }
}
