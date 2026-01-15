//
//  LoginResponse.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import Foundation

struct LoginResponse: Codable {
    let token: String
    let message: String?
}
