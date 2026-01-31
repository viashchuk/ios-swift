//
//  DTO.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 31/01/2026.
//

import Foundation

struct SyncResponse: Codable {
    let categories: [CategoryDTO]
    let products: [ProductDTO]
//    let orders: [OrderDTO]
}

struct CategoryDTO: Codable {
    let id: Int
    let name: String
}

struct ProductDTO: Codable {
    let id: Int
    let name: String
    let details: String?
    let price: Double
    let categoryId: Int
    let imageUrl: String?
    let category: CategoryDTO
    let createdAt: Date?
    let updatedAt: Date?
}

struct OrderDTO: Codable {
    let id: Int
    let userId: Int
    let status: OrderStatus
    let paymentMethod: PaymentMethod
    let createdAt: Date?
    let updatedAt: Date?
    let items: [OrderItemDTO]
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

struct OrderItemDTO: Codable {
    let id: Int
    let orderId: Int
    let productId: Int
    let quantity: Int
    let price: Double
    let product: ProductDTO
    let createdAt: Date?
    let updatedAt: Date?
}

struct UserDTO: Codable {
    let id: Int
    let name: String
    let email: String
}
