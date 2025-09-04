//
//  AddressDetailViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 29/07/25.
//

import UIKit

class AddressDetailsViewController: UIViewController {
    
    private let address: String?
    private let titleLabel = UILabel()
    private let street = UILabel()
    private let deleteButton = UIButton(type: .system)
    
    private let labelsStack = UIStackView()
    private let deleteButtonStack = UIStackView()
    private let mainStack = UIStackView()
    
    
    init(address: String) {
        self.address = address
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Meu Endereço"
        
        setupUI()
    }
    
    private func setupUI() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.distribution = .fillProportionally
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainStack.backgroundColor = .white
        mainStack.layer.cornerRadius = 12
        mainStack.layer.shadowColor = UIColor.black.cgColor
        mainStack.layer.shadowRadius = 6
        mainStack.layer.shadowOpacity = 0.1
        
        labelsStack.axis = .vertical
        labelsStack.distribution = .equalSpacing
        
        street.text = address
        street.numberOfLines = 0
        
        titleLabel.text = "Endereço:"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .red
        deleteButton.addTarget(self, action: #selector(deleteAddress), for: .touchUpInside)
        
        view.addSubview(mainStack)
        
        mainStack.addArrangedSubview(labelsStack)
        mainStack.addArrangedSubview(deleteButton)
        
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(street)

        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            mainStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainStack.trailingAnchor, multiplier: 2),
            mainStack.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}

// MARK: Actions
extension AddressDetailsViewController {
    @objc func deleteAddress() {
        let address = UserDefaults.standard
        address.removeObject(forKey: "hasAddress")
        
        let mapVC = MapViewController()
        navigationController?.setViewControllers([mapVC], animated: true)
    }
}
