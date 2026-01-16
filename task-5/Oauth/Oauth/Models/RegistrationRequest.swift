//
//  RegistrationRequest.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import Foundation

struct RegistrationRequest: Codable {
    let name: String
    let email: String
    let password: String
}

