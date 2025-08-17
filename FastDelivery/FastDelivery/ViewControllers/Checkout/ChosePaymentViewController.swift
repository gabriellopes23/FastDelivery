//
//  ChosePaymentViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 11/08/25.
//

import UIKit

class ChosePaymentViewController: UIViewController {
    
    // Payment Methods
    var inSightPayment: [PaymentModel] = [
        PaymentModel(image: "pixIcon", name: "Pix"),
        PaymentModel(image: "dinheiroIcon", name: "Dinheiro")
    ]
    
    var cardPayment: [PaymentModel] = [
        PaymentModel(image: "eloIcon", name: "Elo"),
        PaymentModel(image: "mastercardIcon", name: "MasterCard"),
        PaymentModel(image: "visaIcon", name: "Visa")
    ]
    
    let scrollView = UIScrollView()
    let rowStackView = UIStackView()
    let mainStackView = UIStackView()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    var selectedRow: UIStackView?
    
    var onPaymenteSelected: ((UIImage?, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        
        let inSightSection = createSection(title: "Pagamento no Local", items: inSightPayment)
        mainStackView.addArrangedSubview(inSightSection)
        
        let cardSection = createSection(title: "Pagamentos com Cartão", items: cardPayment)
        mainStackView.addArrangedSubview(cardSection)
    }
}

// MARK: - Setup / Layout
extension ChosePaymentViewController {
    func setup() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.addArrangedSubview(rowStackView)
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            scrollView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 2),
            scrollView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
    }
}

// MARK: - UI Bilders
extension ChosePaymentViewController {
    func createSection(title: String, items: [PaymentModel]) -> UIStackView {
        let sectionStack = UIStackView()
        sectionStack.axis = .vertical
        sectionStack.spacing = 8
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        sectionStack.addArrangedSubview(titleLabel)
        
        for payment in items {
            let row = createPaymentRow(payment)
            sectionStack.addArrangedSubview(row)
        }
        
        return sectionStack
    }
    
    func createPaymentRow(_ payment: PaymentModel) -> UIStackView {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 10
        row.layer.cornerRadius = 12
        row.layer.borderColor = UIColor.lightGray.cgColor
        row.layer.borderWidth = 1
        row.isLayoutMarginsRelativeArrangement = true
        row.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let imageView = UIImageView(image: UIImage(named: payment.image))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let label = UILabel()
        label.text = payment.name
        
        row.addArrangedSubview(imageView)
        row.addArrangedSubview(label)
        
        row.isUserInteractionEnabled = true
        let tappedGesture = UITapGestureRecognizer(target: self, action: #selector(paymentRowTapped))
        row.addGestureRecognizer(tappedGesture)
        
        return row
    }
    
    @objc func paymentRowTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedRow = sender.view as? UIStackView else { return }
        
        if let previous = selectedRow {
            previous.layer.borderColor = UIColor.lightGray.cgColor
            previous.backgroundColor = .clear
        }
        
        tappedRow.layer.borderColor = UIColor.systemBlue.cgColor
        tappedRow.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        
        selectedRow = tappedRow
        
        if let imgView = tappedRow.arrangedSubviews.first as? UIImageView,
           let titleLabel = tappedRow.arrangedSubviews.last as? UILabel {
            onPaymenteSelected?(imgView.image, titleLabel.text ?? "")
            
            navigationController?.popViewController(animated: true)
        }
    }
}
