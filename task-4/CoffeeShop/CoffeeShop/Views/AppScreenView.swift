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

    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Shop", systemImage: "house")
            }
            
                NavigationStack {
                    OrdersHistoryView()
                }
                .tabItem {
                Label("My Orders", systemImage: "list.bullet.rectangle")
                }
            

            NavigationStack {
                CartView()
            }
            .tabItem {
                Label("Cart", systemImage: "cart")
            }
            .badge(appViewModel.cartItemsCount)
        }
        .tint(Constants.secondary)
        .task {
            await viewModel.startSync()
        }
        
//        VStack(spacing: 24) {
//            
//            CheckoutView()
//
//            Spacer()
//
//            Button(role: .destructive) {
//                loginViewModel.logout()
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
