//
//  LoginResponse.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    let message: String?
    let user: User
}
