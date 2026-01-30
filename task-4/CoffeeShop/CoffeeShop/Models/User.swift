//
//  User.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}
