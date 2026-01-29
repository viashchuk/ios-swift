//
//  WelcomeView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black.opacity(0.95),
                    Color.black.opacity(0.85),
                    Color.black.opacity(0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Go ahead and set up your account")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Text("Sign in-up to enjoy the best app experience")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundStyle(.white.opacity(0.6))
                }
                .padding(.horizontal, 24)
                Spacer()
                
                VStack(spacing: 24) {
                    LoginView()
                        .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                                removal: .move(edge: .leading).combined(with: .opacity)))
                    
                }
                .padding(20)
                .background(Color.white, in: RoundedRectangle(cornerRadius: 32, style: .continuous))
            }
            .padding(.top, 100)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WelcomeView()
}
