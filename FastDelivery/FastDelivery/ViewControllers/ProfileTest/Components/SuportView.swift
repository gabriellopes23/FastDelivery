//
//  SuportView.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 01/09/25.
//

import UIKit

class SupportView: UIView {

    private let imageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let addressLabel = UILabel()
    private let changeAddressButton = UIButton(type: .system)

    private let addressStack = UIStackView()
    private let mainStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Extensions
extension SupportView {
    private func style() {
        addressStack.axis = .vertical
        addressStack.spacing = 8
        
        imageView.image = UIImage(named: "whatsappIcon")
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.6
        
        titleLabel.text = "Suporte"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    
        addressLabel.text = "Fale conosco no WhatsApp"
        
        changeAddressButton.setTitle("Abrir o WhatsApp", for: .normal)
        changeAddressButton.addTarget(self, action: #selector(openSupport), for: .touchUpInside)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.layer.borderWidth = 1
        mainStack.layer.borderColor = UIColor.gray.cgColor
        mainStack.layer.cornerRadius = 12
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    private func layout() {
        addSubview(mainStack)
        
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(addressStack)
        
        addressStack.addArrangedSubview(titleLabel)
        addressStack.addArrangedSubview(addressLabel)
        addressStack.addArrangedSubview(changeAddressButton)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Actions
extension SupportView {
    @objc func openSupport() {
        
    }
}
