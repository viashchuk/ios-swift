//
//  RegistrationView.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 40) {
                    VStack(alignment: .leading, spacing: 16) {
                        InputField(
                            icon: "person",
                            placeholder: "Your Name",
                            text: $viewModel.name
                        )
                        
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
                            .font(.caption)
                    }
                    
                    Button(action: {
                        Task {
                            await viewModel.register()
                        }
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                            .background(Constants.primary)
                            .cornerRadius(60)
                    }
                    .frame(height: 64)
                    
                    Spacer()
                }
                .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                    AppScreenView()
                }
            }
        }
        .background(.white)
    }
}


#Preview {
    RegistrationView()
}
