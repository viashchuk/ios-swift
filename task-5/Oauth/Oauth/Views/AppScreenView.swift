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
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Welcome, \(name) to the App!")
                .font(.title)
            Text(email)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            
            Button(role: .destructive) {
                viewModel.logout()
            } label: {
                Text("Log Out")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }
}
