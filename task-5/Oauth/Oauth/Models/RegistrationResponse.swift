//
//  RegistrationResponse.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import Foundation

struct RegistrationResponse: Codable {
    let token: String
    let user: User
}
