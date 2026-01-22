//
//  LoginView.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
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
                
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(height: 1)
                    
                    Text("Or login with")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .padding(.horizontal, 8)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(height: 1)
                }
                
                HStack(spacing: 24) {
                    
                    Button {
                        Task {
                            await viewModel.loginWithGoogle()
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Image("google_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Text("Google")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 60)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                    }
                    
                    Button {
                        Task {
                            await viewModel.loginWithGitHub()
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Image("github_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            
                            Text("Github")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 60)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                    }
                }
                
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
