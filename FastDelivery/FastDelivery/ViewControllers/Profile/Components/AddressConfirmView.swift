//
//  AddressConfirmView.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 31/07/25.
//

import UIKit

class AddressConfirmView: UIView {
    
    weak var delegate: AddressDetailsModalDelegate?
    
    private let closeButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let streetLabel = UILabel()
    private let neighborhoodLabel = UILabel()
    private let complementTextField = UITextField()
    private let referenceTextField = UITextField()
    private let confirmButton = UIButton(type: .system)
    
    private let closeWrapper = UIView()
    private let stackView = UIStackView()
    
    var prefilledAddress: AddressModel? {
        didSet {
            fillAddress()
        }
    }
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        return UIVisualEffectView(effect: blurEffect)
    }()
    
    init(frame: CGRect, prefilledAddress: AddressModel?, fullAddressText: String?) {
        self.prefilledAddress = prefilledAddress
        super.init(frame: frame)
        
        
        if let text = fullAddressText {
            streetLabel.text = text
        }
        
        blurView.frame = bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        
        setupUI()
        layout()
        fillAddress()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    private func setupUI() {
        closeWrapper.translatesAutoresizingMaskIntoConstraints = false
        closeWrapper.addSubview(closeButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowRadius = 6
        stackView.layer.shadowOpacity = 0.1
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .gray
        closeButton.addTarget(self, action: #selector(closeConfirmAddress), for: .touchUpInside)
        
        titleLabel.text = "Endereço de entrega"
        titleLabel.textColor = .blueColorPersonalizado
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        
        streetLabel.textColor = .secondaryLabel
        streetLabel.textAlignment = .center
        streetLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        streetLabel.numberOfLines = 0
        
        neighborhoodLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        neighborhoodLabel.textColor = .gray
        neighborhoodLabel.numberOfLines = 0
        
        complementTextField.borderStyle = .roundedRect
        complementTextField.placeholder = "Complemento - Apto / Bloco"
        
        referenceTextField.borderStyle = .roundedRect
        referenceTextField.placeholder = "Referência"
        
        confirmButton.setTitle("✔ CONFIRMAR LOCALIZAÇÃO", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        confirmButton.layer.cornerRadius = 10
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.addTarget(self, action: #selector(confirmLocationTapped), for: .touchUpInside)
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(closeWrapper)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(streetLabel)
        stackView.addArrangedSubview(neighborhoodLabel)
        stackView.addArrangedSubview(complementTextField)
        stackView.addArrangedSubview(referenceTextField)
        stackView.addArrangedSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            
            complementTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 2),
            stackView.trailingAnchor.constraint(equalToSystemSpacingAfter: complementTextField.trailingAnchor, multiplier: 2),
            
            referenceTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 2),
            stackView.trailingAnchor.constraint(equalToSystemSpacingAfter: referenceTextField.trailingAnchor, multiplier: 2),
            
            confirmButton.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 2),
            stackView.trailingAnchor.constraint(equalToSystemSpacingAfter: confirmButton.trailingAnchor, multiplier: 2),
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: closeWrapper.topAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: closeButton.trailingAnchor, multiplier: 4),
            closeButton.bottomAnchor.constraint(equalTo: closeWrapper.bottomAnchor),
        ])
        
        closeWrapper.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
    
    private func fillAddress() {
        guard let address = prefilledAddress else { return }
        //        streetLabel.text = "\(address.street), \(address.number)"
        //        neighborhoodLabel.text = "\(address.neighborhood), \(address.city), \(address.cep)"
    }
    
}

// MARK: - Actions
extension AddressConfirmView {
    @objc func closeConfirmAddress() {
        removeFromSuperview()
    }
    
    @objc func confirmLocationTapped() {
//        let address = AddressModel(
//            street: prefilledAddress?.street ?? "",
//            number: prefilledAddress?.number ?? "",
//            neighborhood: prefilledAddress?.neighborhood ?? "",
//            city: prefilledAddress?.city ?? "",
//            state: prefilledAddress?.state ?? "",
//            cep: prefilledAddress?.cep ?? "",
//            country: prefilledAddress?.country ?? "",
//            type: "")
        
        delegate?.didConfirmAddress(streetLabel.text ?? "")
    }
}
