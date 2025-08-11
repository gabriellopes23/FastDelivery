//
//  AddressDetailViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 29/07/25.
//

import UIKit

class AddressDetailsViewController: UIViewController {
    
    private let address: AddressModel
    private let street = UILabel()
    private let number = UILabel()
    private let nighborhood = UILabel()
    private let city = UILabel()
    private let cep = UILabel()
    private let deleteButton = UIButton(type: .system)
    
    private let labelsStack = UIStackView()
    private let mainStack = UIStackView()
    
    
    init(address: AddressModel) {
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
        mainStack.spacing = 5
        mainStack.distribution = .equalSpacing
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainStack.backgroundColor = .white
        mainStack.layer.cornerRadius = 12
        mainStack.layer.shadowColor = UIColor.black.cgColor
        mainStack.layer.shadowRadius = 6
        mainStack.layer.shadowOpacity = 0.1
        
        labelsStack.axis = .vertical
        labelsStack.distribution = .equalSpacing
        
        street.text = "Rua: \(address.street)"
        number.text = "Número: \(address.number)"
        nighborhood.text = "Bairro: \(address.neighborhood)"
        city.text = "Cidade: \(address.city)"
        cep.text = "Cep: \(address.cep)"
        
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .red
        

        view.addSubview(mainStack)
        
        mainStack.addArrangedSubview(labelsStack)
        mainStack.addArrangedSubview(deleteButton)
        
        labelsStack.addArrangedSubview(street)
        labelsStack.addArrangedSubview(number)
        labelsStack.addArrangedSubview(nighborhood)
        labelsStack.addArrangedSubview(city)
        labelsStack.addArrangedSubview(cep)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            mainStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainStack.trailingAnchor, multiplier: 2),
            mainStack.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
