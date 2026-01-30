//
//  ContentView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        Group {
            if viewModel.isLoggedIn, let user = viewModel.currentUser {
                AppScreenView(name: user.name, email: user.email)
                    .transition(.opacity)
            } else {
                WelcomeView()
                    .transition(.opacity)
            }
        }
        .animation(.default, value: viewModel.isLoggedIn)
        .environmentObject(viewModel)
    }
}

#Preview {
    ContentView()
}
