//
//  LoginRequest.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}
