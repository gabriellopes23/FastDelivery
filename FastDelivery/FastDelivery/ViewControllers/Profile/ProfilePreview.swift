//
//  ProfilePreview.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 18/07/25.
//

import UIKit

class ProfilePreview: UIView {
    
    let userImage = UIImageView()
    let userName = UILabel()
    let userEmail = UILabel()
    let userStack = UIStackView()

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
extension ProfilePreview {
    private func setup() {
        userImage.image = UIImage(systemName: "person.circle.fill")
        userImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        userName.text = "Gabriel Lopes"
        userName.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        userEmail.text = "lsl21082000@gmail.com"
        
        userStack.translatesAutoresizingMaskIntoConstraints = false
        userStack.axis = .vertical
        userStack.spacing = 8
        userStack.alignment = .center
        userStack.isLayoutMarginsRelativeArrangement = true
        userStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        userStack.backgroundColor = .white
        userStack.layer.cornerRadius = 12
        userStack.layer.shadowColor = UIColor.black.cgColor
        userStack.layer.shadowRadius = 6
        userStack.layer.shadowOpacity = 0.1
        
        userStack.addArrangedSubview(userImage)
        userStack.addArrangedSubview(userName)
        userStack.addArrangedSubview(userEmail)
    }
    
    private func layout() {
        addSubview(userStack)
        
        NSLayoutConstraint.activate([
            userStack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            userStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: userStack.trailingAnchor),
            userStack.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 2)
        ])
        
        userImage.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
