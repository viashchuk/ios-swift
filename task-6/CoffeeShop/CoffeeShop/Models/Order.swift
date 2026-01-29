//
//  Order.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import Foundation

struct Order: Codable, Identifiable {
    let id: Int
    let userId: String
    let status: OrderStatus
    let paymentMethod: PaymentMethod
    let createdAt: Date?
    let updatedAt: Date?
    let items: [OrderItem]?
    var totalAmount: Double
}

enum OrderStatus: String, Codable {
    case initialized, processing, completed, cancelled
}

enum PaymentMethod: String, Codable {
    case card, cash
    case applePay = "apple_pay"
    case googlePay = "google_pay"
}
