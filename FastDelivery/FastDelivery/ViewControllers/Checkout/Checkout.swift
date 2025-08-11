//
//  Checkout.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 05/08/25.
//

import UIKit

class Checkout: UIViewController {
    
    private let titleLabel = UILabel()
    private let payLabel = UILabel()
    
    private let imagePayment = UIImageView()
    private let typePayment = UILabel()
    private let buttonReplace = UIButton(type: .system)
    private let paymentStack = UIStackView()
    
    private let resumeLabel = UILabel()
    
    private let subtotalLabel = UILabel()
    let subtotalValue = UILabel()
    private let subtotalStack = UIStackView()
    
    private let deliveryLabel = UILabel()
    let deliveryValue = UILabel()
    private let deliveryStack = UIStackView()
    
    private let totalLabel = UILabel()
    let totalValue = UILabel()
    private let totalStack = UIStackView()
    
    private let confirmButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.title = "Resumo"
        
        setupUI()
        layout()
    }
}

// MARK: - Extensions
extension Checkout {
    private func setupUI() {
        payLabel.translatesAutoresizingMaskIntoConstraints = false
        payLabel.text = "Pagamento pelo app"
        payLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        paymentStack.translatesAutoresizingMaskIntoConstraints = false
        paymentStack.axis = .horizontal
        paymentStack.distribution = .equalSpacing
        
        imagePayment.image = UIImage(named: "pixIcon")
        imagePayment.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imagePayment.widthAnchor.constraint(equalToConstant: 25).isActive = true
        typePayment.text = "Pix"
        typePayment.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        buttonReplace.setTitle("Trocar", for: .normal)
        buttonReplace.addTarget(self, action: #selector(chosePaymentMethod), for: .touchUpInside)
        
        paymentStack.addArrangedSubview(imagePayment)
        paymentStack.addArrangedSubview(typePayment)
        paymentStack.addArrangedSubview(buttonReplace)
        
        resumeLabel.translatesAutoresizingMaskIntoConstraints = false
        resumeLabel.text = "Resumo de Valores"
        resumeLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        
        subtotalStack.translatesAutoresizingMaskIntoConstraints = false
        subtotalStack.axis = .horizontal
        subtotalStack.distribution = .equalSpacing
        subtotalLabel.text = "Subtotal"
        subtotalLabel.font = .systemFont(ofSize: 16, weight: .light)
        subtotalValue.font = .systemFont(ofSize: 16, weight: .light)
        subtotalStack.addArrangedSubview(subtotalLabel)
        subtotalStack.addArrangedSubview(subtotalValue)
        
        deliveryStack.translatesAutoresizingMaskIntoConstraints = false
        deliveryStack.axis = .horizontal
        deliveryStack.distribution = .equalSpacing
        deliveryLabel.text = "Taxa de Entrega"
        deliveryLabel.font = .systemFont(ofSize: 16, weight: .light)
        deliveryValue.text = "R$10,00"
        deliveryValue.font = .systemFont(ofSize: 16, weight: .light)
        deliveryStack.addArrangedSubview(deliveryLabel)
        deliveryStack.addArrangedSubview(deliveryValue)
        
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        totalStack.axis = .horizontal
        totalStack.distribution = .equalSpacing
        totalLabel.text = "Total"
        totalLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        totalValue.font = .systemFont(ofSize: 18, weight: .semibold)
        totalStack.addArrangedSubview(totalLabel)
        totalStack.addArrangedSubview(totalValue)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle("Finalizar Pedido", for: .normal)
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.backgroundColor = .systemBlue
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        confirmButton.layer.cornerRadius = 12
    }
    
    private func layout() {
        view.addSubview(payLabel)
        view.addSubview(paymentStack)
        view.addSubview(resumeLabel)
        view.addSubview(subtotalStack)
        view.addSubview(deliveryStack)
        view.addSubview(totalStack)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            payLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            payLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: payLabel.trailingAnchor, multiplier: 2),
            
            paymentStack.topAnchor.constraint(equalToSystemSpacingBelow: payLabel.bottomAnchor, multiplier: 1),
            paymentStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: paymentStack.trailingAnchor, multiplier: 2),
            
            resumeLabel.topAnchor.constraint(equalToSystemSpacingBelow: paymentStack.bottomAnchor, multiplier: 4),
            resumeLabel.leadingAnchor.constraint(equalTo: payLabel.leadingAnchor),
            resumeLabel.trailingAnchor.constraint(equalTo: payLabel.trailingAnchor),
            
            subtotalStack.topAnchor.constraint(equalToSystemSpacingBelow: resumeLabel.bottomAnchor, multiplier: 2),
            subtotalStack.leadingAnchor.constraint(equalTo: payLabel.leadingAnchor),
            subtotalStack.trailingAnchor.constraint(equalTo: payLabel.trailingAnchor),
            
            deliveryStack.topAnchor.constraint(equalToSystemSpacingBelow: subtotalStack.bottomAnchor, multiplier: 2),
            deliveryStack.leadingAnchor.constraint(equalTo: payLabel.leadingAnchor),
            deliveryStack.trailingAnchor.constraint(equalTo: payLabel.trailingAnchor),
            
            totalStack.topAnchor.constraint(equalToSystemSpacingBelow: deliveryStack.bottomAnchor, multiplier: 2),
            totalStack.leadingAnchor.constraint(equalTo: payLabel.leadingAnchor),
            totalStack.trailingAnchor.constraint(equalTo: payLabel.trailingAnchor),
            
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            confirmButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: confirmButton.trailingAnchor, multiplier: 2)
        ])
    }
    
    @objc func chosePaymentMethod() {
        let vc = ChosePaymentViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


