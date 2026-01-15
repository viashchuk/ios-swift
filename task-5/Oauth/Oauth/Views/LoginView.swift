//
//  LoginView.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 16) {
                    InputField(
                        icon: "envelope",
                        placeholder: "Email Address",
                        text: $viewModel.email
                    )
                    
                    InputField(
                        icon: "lock",
                        placeholder: "Password",
                        text: $viewModel.password,
                        isPassword: true
                    )
                }
                .padding(.horizontal)
                
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Button(action: {
                    Task {
                        await viewModel.login()
                    }}) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                            .background(Constants.primary)
                            .cornerRadius(60)
                    }
                    .padding(.horizontal)
                    .frame(height: 64)
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                AppScreenView()
            }
        }
    }
}

#Preview {
    LoginView()
}
