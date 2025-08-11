//
//  CartCollectionCell.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 16/07/25.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    static let reuseID = "CartItemCell"
    
    private var item: Product?
    var onTotalPriceChanged: ((Double) -> Void)?
    
    private let imageViewCell = UIImageView()
    private let nameProductLabel = UILabel()
    private let unitValueLabel = UILabel()
    private let quantLabel = UILabel()
    
    private let totalValueLabel = UILabel()
    private let stepper = UIStepper()
    
    private let labelStack = UIStackView()
    private let totalStack = UIStackView()
    private let mainStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGroupedBackground
        
        setup()
        styleCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageViewCell.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageViewCell.contentMode = .scaleAspectFill
        
        labelStack.axis = .vertical
        labelStack.spacing = 8
        labelStack.addArrangedSubview(nameProductLabel)
        labelStack.addArrangedSubview(unitValueLabel)
        labelStack.addArrangedSubview(quantLabel)
        
        totalStack.axis = .vertical
        totalStack.spacing = 8
        totalStack.alignment = .center
        totalStack.addArrangedSubview(totalValueLabel)
        totalStack.addArrangedSubview(stepper)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .horizontal
        mainStack.spacing = 8
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainStack.backgroundColor = .white
        mainStack.layer.cornerRadius = 12
        mainStack.layer.shadowColor = UIColor.black.cgColor
        mainStack.layer.shadowRadius = 6
        mainStack.layer.shadowOpacity = 0.1
        mainStack.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainStack.addArrangedSubview(imageViewCell)
        mainStack.addArrangedSubview(labelStack)
        mainStack.addArrangedSubview(totalStack)
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    private func styleCell() {
        nameProductLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameProductLabel.textAlignment = .center
        
        unitValueLabel.font = UIFont.systemFont(ofSize: 16)
        quantLabel.font = UIFont.systemFont(ofSize: 14)
        totalValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
    }
    
    func config(with item: CartItem) {
        self.item = item.produtc
        imageViewCell.image = UIImage(named: item.produtc.image)
        nameProductLabel.text = item.produtc.title
        unitValueLabel.text = item.produtc.price
        quantLabel.text = "x\(item.quantity)"
        stepper.value = Double(item.quantity)
        updateTotalPrice(quantity: item.quantity)
    }
    
    private func updateTotalPrice(quantity: Int) {
        guard let item = item else { return }
        let priceString = item.price.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: ".")
        guard let unitPrice = Double(priceString) else { return }
        
        let total = unitPrice * Double(quantity)
        let formattedTotal = String(format: "R$%.2f", total).replacingOccurrences(of: ".", with: ",")
        totalValueLabel.text = formattedTotal
        onTotalPriceChanged?(total)
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        quantLabel.text = "x\(value)"
        updateTotalPrice(quantity: value)
        
        if let item = item {
            CartService.shared.updateQuantity(for: item, quantity: value)
        }
    }
}


