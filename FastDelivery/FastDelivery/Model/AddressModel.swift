//
//  AddressModel.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 23/07/25.
//

import Foundation

struct AddressModel: Codable {
    let street: String
    let number: String
    let neighborhood: String
    let city: String
    let state: String
    let cep: String
    let country: String
    let type: String
}
