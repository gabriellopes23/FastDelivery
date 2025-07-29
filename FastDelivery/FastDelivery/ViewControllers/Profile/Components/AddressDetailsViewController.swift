//
//  AddressDetailsViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 29/07/25.
//

import UIKit

class AddressDetailsViewController: UIViewController {
    
    private let address: AddressModel

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
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)

        label.text = """
        Rua: \(address.street)
        Número: \(address.number)
        Bairro: \(address.neighborhood)
        Cidade: \(address.city)
        CEP: \(address.cep)
        """

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
