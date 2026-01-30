//
//  Category.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import Foundation

struct Category: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let createdAt: Date?
    let updatedAt: Date?
}

