//
//  CartService.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 21/07/25.
//

import Foundation

class CartService {
    static let shared = CartService()
    
    private(set) var items: [CartItem] = []
    
    private init() {}
    
    func addItem(_ product: Product) {
        if let index = items.firstIndex(where: { $0.produtc.title == product.title }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(produtc: product, quantity: 1))
        }
    }
    
    func updateQuantity(for produtct: Product, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.produtc.title == produtct.title }) else { return }
        items[index].quantity = quantity
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
    }
    
    func clearCart() {
        items.removeAll()
        // Postar notificação para atualizar o CartViewController
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
    }
    
    func remove(_ product: Product) {
        if let index = items.firstIndex(where: { $0.produtc.title == product.title}) {
            items.remove(at: index)
        }
    }
}
