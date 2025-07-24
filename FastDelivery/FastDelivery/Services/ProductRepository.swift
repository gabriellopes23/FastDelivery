//
//  ProductRepository.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 21/07/25.
//

import Foundation


final class ProductRepository {
    static func getDefaultProducts() -> [Product] {
        return [
            Product(image: "botijao", title: "Gás P13", price: "R$125,00"),
            Product(image: "botijao", title: "Gás P13 Completo", price: "R$330,00"),
            Product(image: "galao", title: "Água Mineral 20L", price: "R$12,00"),
            Product(image: "galao", title: "Galão 20L Completo", price: "R$45,00")
        ]
    }
}
