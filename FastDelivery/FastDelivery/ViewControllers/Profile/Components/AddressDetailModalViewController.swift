//
//  AddressDetailModalViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 23/07/25.
//

import UIKit

protocol AddressDetailsModalDelegate: AnyObject {
    func didConfirmAddress(_ address: AddressModel)
}

class AddressDetailsModalViewController: UIViewController {

    weak var delegate: AddressDetailsModalDelegate?

    private let streetTextField = UITextField()
    private let numberTextField = UITextField()
    private let complementTextField = UITextField()
    private let cepTextField = UITextField()
    private let confirmButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        title = "Confirmar Endereço"

        streetTextField.placeholder = "Rua"
        numberTextField.placeholder = "Número"
        complementTextField.placeholder = "Complemento (opcional)"
        cepTextField.placeholder = "CEP"

        [streetTextField, numberTextField, complementTextField, cepTextField].forEach {
            $0.borderStyle = .roundedRect
        }

        confirmButton.setTitle("Confirmar", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [
            cepTextField,
            streetTextField,
            numberTextField,
            complementTextField,
            confirmButton
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    @objc private func confirmTapped() {
        guard let cep = cepTextField.text, !cep.isEmpty,
              let street = streetTextField.text, !street.isEmpty,
              let number = numberTextField.text, !number.isEmpty else {
            showAlert(message: "Preencha todos os campos obrigatórios.")
            return
        }

        let address = AddressModel(
            street: street,
            number: number,
            neighborhood: "",
            city: "",
            cep: "",
            type: ""
        )

        delegate?.didConfirmAddress(address)
        dismiss(animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
