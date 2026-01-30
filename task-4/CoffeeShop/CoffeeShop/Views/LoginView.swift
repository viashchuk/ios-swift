//
//  LoginView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
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
                    .frame(height: 64)
                Spacer()
            }
            .padding(0)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
