//
//  OrderResponse.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import Foundation

struct OrderResponse: Codable {
    let success: Bool
    let orders: [Order]
}
