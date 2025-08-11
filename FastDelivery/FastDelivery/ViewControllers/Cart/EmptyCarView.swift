//
//  EmptyCarView.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 03/08/25.
//

import UIKit

class EmptyCarView: UIView {

    private let imageView = UIImageView()
    private let label = UILabel()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    private func setupUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        
        imageView.image = UIImage(systemName: "cart.badge.plus.fill")
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.tintColor = .gray
        
        label.text = "Sem item no carrinho."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
