//
//  ConfigViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 19/07/25.
//

import UIKit

class ConfigsPreview: UIView {
    
    private var tableView: UITableView!
    
    private var address: AddressModel?
    
    var data = ["Meu Endereço", "Formas de Pagamentos", "Configurações", "Ajuda"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension
extension ConfigsPreview {
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 2)
        ])
    }
}

// MARK: - UITableViewDataSource
extension ConfigsPreview: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension ConfigsPreview: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let parentVC = self.parentViewController else { return }
        
        if data[indexPath.row] == "Meu Endereço" {
            if let data = UserDefaults.standard.data(forKey: "userAddress"),
               let address = try? JSONDecoder().decode(AddressModel.self, from: data) {
                
                let vc = AddressDetailsViewController(address: address)
                parentVC.navigationController?.pushViewController(vc, animated: true)
            }
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
