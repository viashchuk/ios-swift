//
//  PaymentResponse.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

struct PaymentResponse: Codable {
    let success: Bool
    let order: Order?
    let message: String?
    let error: String?
}
