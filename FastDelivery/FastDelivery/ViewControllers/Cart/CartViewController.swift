//
//  CartViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 14/07/25.
//

import UIKit

class CartViewController: UIViewController {
    
    private var products: [CartItem] {
        return CartService.shared.items
    }
    
    private var itemTotalValues: [String: Double] = [:]

    var collectionView: UICollectionView!
    
    var subTotalLabel = UILabel()
    var subTotalValue = UILabel()
    
    var deliveryLabel = UILabel()
    var deliveryValue = UILabel()
    
    var totalLabel = UILabel()
    var totalValue = UILabel()
    
    var subTotalStack = UIStackView()
    var deliveryStack = UIStackView()
    var totalStack = UIStackView()
    
    var mainStack = UIStackView()
    
    let completeOrderButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Meu Carrinho"
        
        let titleFont = UIFont.systemFont(ofSize: 32, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: UIColor.label
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        view.backgroundColor = .systemGroupedBackground
        
        style()
        setupCollection()
        layout()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .cartDidUpdate, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        calculateSubtotal()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartDidUpdate, object: nil)
    }

    private func calculateSubtotal() {
        var subTotal: Double = 0.0
        let taxaEntrega: Double = 10.0
        var total: Double = 0.0
        for product in products {
            if let value = itemTotalValues[product.produtc.title] {
                subTotal += value
                let temp = subTotal + taxaEntrega
                total = temp
            } else {
                // fallback: pega o valor unitário se não tiver valor na célula
                let priceString = product.produtc.price.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: ".")
                if let price = Double(priceString) {
                    subTotal += price
                    itemTotalValues[product.produtc.title] = price
                    let temp = subTotal + taxaEntrega
                    total = temp
                }
            }
        }
        subTotalValue.text = String(format: "R$%.2f", subTotal).replacingOccurrences(of: ".", with: ",")
        totalValue.text = String(format: "R$%.2f", total).replacingOccurrences(of: ".", with: ",")
    }

}

// MARK: - Extensions
extension CartViewController {
    private func style() {
        // Labels
        subTotalLabel.text = "Subtotal"
        subTotalValue.text = "R$102,00"
        deliveryLabel.text = "Taxa de Entrega"
        deliveryValue.text = "R$10,00"
        totalLabel.text = "Total"
        totalValue.text = "R$109,00"
        
        // MARK: - HORIZONTAL STACKS
        subTotalStack.axis = .horizontal
        subTotalStack.distribution = .equalSpacing
        subTotalStack.addArrangedSubview(subTotalLabel)
        subTotalStack.addArrangedSubview(subTotalValue)
        
        deliveryStack.axis = .horizontal
        deliveryStack.distribution = .equalSpacing
        deliveryStack.addArrangedSubview(deliveryLabel)
        deliveryStack.addArrangedSubview(deliveryValue)
        
        totalStack.axis = .horizontal
        totalStack.distribution = .equalSpacing
        totalStack.addArrangedSubview(totalLabel)
        totalStack.addArrangedSubview(totalValue)
        
        // MARK: - MAIN VERTICAL STACK
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.backgroundColor = .white
        mainStack.layer.cornerRadius = 12
        mainStack.layer.shadowColor = UIColor.black.cgColor
        mainStack.layer.shadowRadius = 6
        mainStack.layer.shadowOpacity = 0.1
        mainStack.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainStack.addArrangedSubview(subTotalStack)
        mainStack.addArrangedSubview(deliveryStack)
        
        // Divide
        let divide = UIView()
        divide.backgroundColor = .lightGray
        divide.heightAnchor.constraint(equalToConstant: 1).isActive = true
        mainStack.addArrangedSubview(divide)
        
        // TOTAL
        mainStack.addArrangedSubview(totalStack)
        
        // MARK: - COMPLETE BUTTON
        completeOrderButton.translatesAutoresizingMaskIntoConstraints = false
        completeOrderButton.setTitle("Finalizar Pedido", for: .normal)
        completeOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        completeOrderButton.backgroundColor = .systemBlue
        completeOrderButton.setTitleColor(.white, for: .normal)
        completeOrderButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        completeOrderButton.layer.cornerRadius = 12
        completeOrderButton.addTarget(self, action: #selector(completeOrder), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(collectionView)
        view.addSubview(mainStack)
        view.addSubview(completeOrderButton)
        
        let screenHeight = UIScreen.main.bounds.height
        let collectionHeight = screenHeight * 0.45
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 2),
            collectionView.heightAnchor.constraint(equalToConstant: collectionHeight),
            
            mainStack.topAnchor.constraint(equalToSystemSpacingBelow: collectionView.bottomAnchor, multiplier: 2),
            mainStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainStack.trailingAnchor, multiplier: 2),
           
            completeOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            completeOrderButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: completeOrderButton.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.size.width), height: (view.frame.size.width/2.7)-4)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CartItemCell.self, forCellWithReuseIdentifier: CartItemCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGroupedBackground
    }
}

// MARK: - UICollectionViewDataSource
extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCell.reuseID, for: indexPath) as? CartItemCell else { return UICollectionViewCell() }
        
        let product = products[indexPath.item]
        cell.config(with: product)
        cell.onTotalPriceChanged = { [weak self] totalValue in
            guard let self = self else { return }
            self.itemTotalValues[product.produtc.title] = totalValue
            self.calculateSubtotal()
        }
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension CartViewController: UICollectionViewDelegate {
    
}



extension Notification.Name {
    static let cartDidUpdate = Notification.Name("cartDidUpdate")
}

// MARK: - Actions
extension CartViewController {
    @objc func cartUpdated() {
        collectionView.reloadData()
        calculateSubtotal()
    }
    
    @objc func completeOrder() {
        let vc = CheckoutViewController()
        
        vc.cartItems = CartService.shared.items
        vc.subtotalText = subTotalValue.text ?? "R$0,00"
        vc.totalText = totalValue.text ?? "R$0,00"
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
