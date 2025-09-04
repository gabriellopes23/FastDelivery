//
//  AddressView.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 30/08/25.
//

import UIKit

class AddressView: UIView {

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
        loadAddress()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadAddress() {
        if let data = UserDefaults.standard.data(forKey: "userAddress"),
           let savedAddress = try? JSONDecoder().decode(String.self, from: data) {
            addressLabel.text = savedAddress
        } else {
            addressLabel.text = "Nenhum endereço cadastrado!"
        }
    }
}

// MARK: - Extensions
extension AddressView {
    private func style() {
        addressStack.axis = .vertical
        addressStack.spacing = 8
        
        imageView.image = UIImage(systemName: "mappin.and.ellipse.circle.fill")
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.tintColor = .systemGray
        
        titleLabel.text = "Endereço"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        changeAddressButton.setTitle("Alterar Endereço", for: .normal)
        changeAddressButton.addTarget(self, action: #selector(changeAddress), for: .touchUpInside)
        
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
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Actions
extension AddressView {
    @objc func changeAddress() {
        if let parentVC = self.parentViewController {
            let vc = MapViewController()
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - ParentViewController
extension UIView {
    var parentViewController: UIViewController? {
        var responder:  UIResponder? = self
        while responder != nil {
            if let vc = responder as? UIViewController {
                return vc
            }
            responder = responder?.next
        }
        return nil
    }
}
