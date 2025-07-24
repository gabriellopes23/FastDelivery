//
//  DeliveryView.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 18/07/25.
//

import UIKit

class DeliveryView: UIView {
    
    let titleLabel = UILabel()
    
    let addressLabel = UILabel()
    
    let paymentLabel = UILabel()
    
    let mainStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions
extension DeliveryView {
    private func setup() {
        titleLabel.text = "Entrega"
        
        addressLabel.text = "Av: Paulista. 1000, Bela Vista São Paulo - 0000,00"
        addressLabel.numberOfLines = 2
        
        paymentLabel.text = "Forma de pagamento - Cartão de Crédito"
        paymentLabel.numberOfLines = 2
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.distribution = .equalCentering
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainStack.backgroundColor = .white
        mainStack.layer.cornerRadius = 12
        mainStack.layer.shadowColor = UIColor.black.cgColor
        mainStack.layer.shadowRadius = 6
        mainStack.layer.shadowOpacity = 0.1
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(createDivider())
        mainStack.addArrangedSubview(addressLabel)
        mainStack.addArrangedSubview(createDivider())
        mainStack.addArrangedSubview(paymentLabel)
        
    }
    
    private func layout() {
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            mainStack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: mainStack.trailingAnchor, multiplier: 2),
            mainStack.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 2)
        ])
    }
    private func createDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return divider
    }
}
