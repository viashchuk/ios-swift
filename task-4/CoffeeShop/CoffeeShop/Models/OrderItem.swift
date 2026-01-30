//
//  OrderItem.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import Foundation

struct OrderItem: Codable, Identifiable {
    let id: Int
    let orderId: String
    let productId: String
    let quantity: Int
    let price: Double
    let product: Product?
    let createdAt: Date?
    let updatedAt: Date?
}
