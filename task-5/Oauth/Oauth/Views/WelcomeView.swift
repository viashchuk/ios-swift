//
//  ContentView.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import SwiftUI

struct WelcomeView: View {
    enum Tab: String, CaseIterable {
        case login = "Login"
        case register = "Register"
    }
        
    @State private var activeTab: Tab = .login
    
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
                    Tabs(
                        tabs: Tab.allCases.map { $0.rawValue },
                        selectedTabIndex: selectedTabIndex
                    )
                    
                    currentForm
                        .animation(.easeInOut(duration: 0.25), value: activeTab)
                    
                    Spacer()
                }
                .padding(20)
                .background(Color.white, in: RoundedRectangle(cornerRadius: 32, style: .continuous))
            }
            .padding(.top, 100)
            .ignoresSafeArea()
        }
    }
    
    private var selectedTabIndex: Binding<Int> {
        Binding(
            get: { Tab.allCases.firstIndex(of: activeTab) ?? 0 },
            set: { activeTab = Tab.allCases[$0] }
        )
    }
    
    @ViewBuilder
    private var currentForm: some View {
        switch activeTab {
        case .login:
            LoginView()
                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity),
                                        removal: .move(edge: .leading).combined(with: .opacity)))
        case .register:
            RegistrationView()
                .transition(.asymmetric(insertion: .move(edge: .leading).combined(with: .opacity),
                                        removal: .move(edge: .trailing).combined(with: .opacity)))
        }
    }
}

#Preview {
    WelcomeView()
}
