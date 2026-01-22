//
//  AppScreenView.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import SwiftUI

struct AppScreenView: View {
    let name: String
    let email: String
    
    var body: some View {
        VStack {
            Text("Welcome, \(name) to the App!")
                .font(.title)
            Text(email)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
