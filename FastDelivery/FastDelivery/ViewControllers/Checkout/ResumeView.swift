//
//  ResumeView.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 18/07/25.
//

import UIKit

class ResumeView: UIView {
    
    let titleLabel = UILabel()
    
    private var products: [CartItem] {
        return CartService.shared.items
    }
    
    // Produtos
    let productStack = UIStackView()
    
    // SubTotal
    let subtotalLabel = UILabel()
    let subtotalValue = UILabel()
    let subtotalStack = UIStackView()
    
    let taxaLabel = UILabel()
    let taxaValue = UILabel()
    let taxaStack = UIStackView()
    
    let totalLabel = UILabel()
    let totalValue = UILabel()
    let totalStack = UIStackView()
    
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

// MARK: - Extension
extension ResumeView {
    private func setup() {
        titleLabel.text = "Resumo"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        productStack.translatesAutoresizingMaskIntoConstraints = false
        productStack.axis = .vertical
        productStack.distribution = .equalCentering
        productStack.addArrangedSubview(createProductRow(quantity: "1x", product: "Botijão de Gás (13kg)", price: "R$70,00"))
        productStack.addArrangedSubview(createProductRow(quantity: "2x", product: "Galão de Água (20L)", price: "R$30,00"))
        
        subtotalLabel.text = "Subtotal"
        subtotalValue.text = "R$130,00"
        subtotalStack.translatesAutoresizingMaskIntoConstraints = false
        subtotalStack.axis = .horizontal
        subtotalStack.distribution = .equalCentering
        subtotalStack.addArrangedSubview(subtotalLabel)
        subtotalStack.addArrangedSubview(subtotalValue)
        
        taxaLabel.text = "Taxa de entrega"
        taxaValue.text = "R$10,00"
        taxaStack.translatesAutoresizingMaskIntoConstraints = false
        taxaStack.axis = .horizontal
        taxaStack.distribution = .equalCentering
        taxaStack.addArrangedSubview(taxaLabel)
        taxaStack.addArrangedSubview(taxaValue)
        
        totalLabel.text = "Total"
        totalLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        totalValue.text = "150,00"
        totalValue.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        totalStack.translatesAutoresizingMaskIntoConstraints = false
        totalStack.axis = .horizontal
        totalStack.distribution = .equalCentering
        totalStack.addArrangedSubview(totalLabel)
        totalStack.addArrangedSubview(totalValue)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainStack.backgroundColor = .white
        mainStack.layer.cornerRadius = 12
        mainStack.layer.shadowColor = UIColor.black.cgColor
        mainStack.layer.shadowRadius = 6
        mainStack.layer.shadowOpacity = 0.1
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(createDivider())
        mainStack.addArrangedSubview(productStack)
        mainStack.addArrangedSubview(createDivider())
        mainStack.addArrangedSubview(subtotalStack)
        mainStack.addArrangedSubview(taxaStack)
        mainStack.addArrangedSubview(createDivider())
        mainStack.addArrangedSubview(totalStack)
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
    private func createProductRow(quantity: String, product: String, price: String) -> UIStackView {
        let quantityLabel = UILabel()
        quantityLabel.text = quantity
        
        let productLabel = UILabel()
        productLabel.text = product
        
        let priceLabel = UILabel()
        priceLabel.text = price
        
        let stack = UIStackView(arrangedSubviews: [quantityLabel, productLabel, priceLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }
    
    func checkoutProducts(cartItems: [CartItem], subtotal: String, total: String, delivery: String) {
        productStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for cartItem in cartItems {
            let row = createProductRow(quantity: "\(cartItem.quantity)x", product: cartItem.produtc.title, price: cartItem.produtc.price)
            productStack.addArrangedSubview(row)
        }
        
        subtotalValue.text = subtotal
        taxaValue.text = delivery
        totalValue.text = total
    }
}
