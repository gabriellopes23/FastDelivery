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
    
    var tableView = UITableView()
    
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
    
    let emptyCartView = EmptyCarView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Meu Carrinho"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 32, weight: .bold),
            .foregroundColor: UIColor.label
        ]
        
        view.backgroundColor = .systemGroupedBackground
        style()
        setupTable()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        calculateSubtotal()
        updateUI()
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartDidUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 220
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    private func style() {
        subTotalLabel.text = "Subtotal"
        deliveryLabel.text = "Taxa de Entrega"
        totalLabel.text = "Total"
        subTotalValue.text = "R$0,00"
        deliveryValue.text = "R$10,00"
        totalValue.text = "R$0,00"
        
        [subTotalStack, deliveryStack, totalStack].forEach {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
        }
        
        subTotalStack.addArrangedSubview(subTotalLabel)
        subTotalStack.addArrangedSubview(subTotalValue)
        deliveryStack.addArrangedSubview(deliveryLabel)
        deliveryStack.addArrangedSubview(deliveryValue)
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
        mainStack.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        mainStack.addArrangedSubview(subTotalStack)
        mainStack.addArrangedSubview(deliveryStack)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        mainStack.addArrangedSubview(divider)
        
        mainStack.addArrangedSubview(totalStack)
        
        completeOrderButton.translatesAutoresizingMaskIntoConstraints = false
        completeOrderButton.setTitle("Finalizar Pedido", for: .normal)
        completeOrderButton.backgroundColor = .systemBlue
        completeOrderButton.setTitleColor(.white, for: .normal)
        completeOrderButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        completeOrderButton.layer.cornerRadius = 12
        completeOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        completeOrderButton.addTarget(self, action: #selector(completeOrder), for: .touchUpInside)
    }
    
    private func layout() {
        emptyCartView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(emptyCartView)
        view.addSubview(tableView)
        view.addSubview(mainStack)
        view.addSubview(completeOrderButton)
        
        let screenHeight = UIScreen.main.bounds.height
        let tableHeight = screenHeight * 0.45
        
        NSLayoutConstraint.activate([
            emptyCartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyCartView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: emptyCartView.trailingAnchor, multiplier: 2),
            emptyCartView.heightAnchor.constraint(equalToConstant: tableHeight),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 2),
            tableView.heightAnchor.constraint(equalToConstant: tableHeight),
            
            mainStack.topAnchor.constraint(equalToSystemSpacingBelow: products.isEmpty == true ? emptyCartView.bottomAnchor : tableView.bottomAnchor , multiplier: 2),
            mainStack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: mainStack.trailingAnchor, multiplier: 2),
            
            completeOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            completeOrderButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: completeOrderButton.trailingAnchor, multiplier: 2)
        ])
    }
    
    private func calculateSubtotal() {
        var subTotal = 0.0
        let deliveryFee = 10.0
        
        for product in products {
            let title = product.produtc.title
            if let value = itemTotalValues[title] {
                subTotal += value
            } else {
                let priceString = product.produtc.price.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: ".")
                if let price = Double(priceString) {
                    let total = price * Double(product.quantity)
                    subTotal += total
                    itemTotalValues[title] = total
                }
            }
        }
        
        subTotalValue.text = String(format: "R$%.2f", subTotal).replacingOccurrences(of: ".", with: ",")
        let total = subTotal + deliveryFee
        totalValue.text = String(format: "R$%.2f", total).replacingOccurrences(of: ".", with: ",")
    }
    
    @objc func cartUpdated() {
        tableView.reloadData()
        calculateSubtotal()
        updateUI()
    }
    
    private func updateUI() {
        let isEmpty = products.isEmpty
        
        tableView.isHidden = isEmpty
        emptyCartView.isHidden = !isEmpty
    }
    
    @objc func completeOrder() {
        if !products.isEmpty {
            let vc = Checkout()
            vc.subtotalValue.text = subTotalValue.text ?? "R$0,00"
            vc.totalValue.text = totalValue.text ?? "R$0,00"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.reuseID, for: indexPath) as? CartItemCell else {
            return UITableViewCell()
        }
        
        let item = products[indexPath.row]
        cell.config(with: item)
        cell.selectionStyle = .none
        
        cell.onTotalPriceChanged = { [weak self] total in
            self?.itemTotalValues[item.produtc.title] = total
            self?.calculateSubtotal()
        }
        
        return cell
    }
    
    // Swipe para deletar
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Excluir") { [weak self] (_, _, completion) in
            guard let self = self else { return }
            let product = self.products[indexPath.row]
            CartService.shared.remove(product.produtc)
            self.itemTotalValues.removeValue(forKey: product.produtc.title)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.calculateSubtotal()
            self.updateUI()
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


// MARK: - UICollectionViewDelegate
extension CartViewController: UICollectionViewDelegate {
    
}

extension Notification.Name {
    static let cartDidUpdate = Notification.Name("cartDidUpdate")
}

