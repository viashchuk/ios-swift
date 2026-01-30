//
//  Product.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let price: Double
    let categoryId: String
    let imageUrl: String?
    let category: Category?
    let createdAt: Date?
    let updatedAt: Date?
}
