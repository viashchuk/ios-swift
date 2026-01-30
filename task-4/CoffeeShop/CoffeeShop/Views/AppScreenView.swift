//
//  AppScreenView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import Combine
import SwiftUI

struct AppScreenView: View {
    let name: String
    let email: String

    @EnvironmentObject var viewModel: LoginViewModel

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Shop", systemImage: "house")
            }
            
//            NavigationStack {
//                CartView()
//            }
//            .tabItem {
//                Label("Cart", systemImage: "cart")
//            }
//            .badge(cartItems.reduce(0) { $0 + Int($1.quantity) })
        }
        .tint(Constants.secondary)
        
//        VStack(spacing: 24) {
//            
//            CheckoutView()
//
//            Spacer()
//
//            Button(role: .destructive) {
//                viewModel.logout()
//            } label: {
//                Text("Log Out")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.red.opacity(0.1))
//                    .cornerRadius(12)
//            }
//            .padding(.horizontal, 24)
//            .padding(.bottom, 40)
    }
}
