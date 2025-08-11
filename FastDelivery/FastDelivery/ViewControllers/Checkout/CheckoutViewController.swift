//
//  CheckoutViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 18/07/25.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    let resumoView = ResumeView()
    var deliveryView = DeliveryView()
    let confirmButton = UIButton(type: .system)
    
    var cartItems: [CartItem] = []
    var subtotalText: String = ""
    var totalText: String = ""
    var quantityText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .systemGroupedBackground
        
        
        setup()
        layout()
        
        resumoView.checkoutProducts(cartItems: cartItems, subtotal: subtotalText, total: totalText, delivery: "R$10,00")
        
        if let address = loadSavedAddress() {
               deliveryView.setAddress(address)
           }
    }
}

// MARK: - Extensions
extension CheckoutViewController {
    private func setup() {
        resumoView.translatesAutoresizingMaskIntoConstraints = false
        deliveryView.translatesAutoresizingMaskIntoConstraints = false
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle("Finalizar Pedido", for: .normal)
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.backgroundColor = .systemBlue
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        confirmButton.layer.cornerRadius = 12
    }
    
    private func layout() {
        view.addSubview(resumoView)
        view.addSubview(deliveryView)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            resumoView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            resumoView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: resumoView.trailingAnchor, multiplier: 2),
            
            deliveryView.topAnchor.constraint(equalToSystemSpacingBelow: resumoView.bottomAnchor, multiplier: 2),
            deliveryView.leadingAnchor.constraint(equalTo: resumoView.leadingAnchor),
            deliveryView.trailingAnchor.constraint(equalTo: resumoView.trailingAnchor),
            
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            confirmButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: confirmButton.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func loadSavedAddress() -> AddressModel? {
        if let data = UserDefaults.standard.data(forKey: "userAddress") {
            do {
                let address = try JSONDecoder().decode(AddressModel.self, from: data)
                return address
            } catch {
                print("Erro ao decodificar endereço: \(error)")
            }
        }
        return nil
    }
}
