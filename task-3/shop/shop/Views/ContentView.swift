//
//  ContentView.swift
//  shop
//
//  Created by Victoria Iashchuk on 11/12/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], animation: .default)
    private var cartItems: FetchedResults<CartItem>
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Shop", systemImage: "house")
            }
            
            NavigationStack {
                CartView()
            }
            .tabItem {
                Label("Cart", systemImage: "cart")
            }
            .badge(cartItems.reduce(0) { $0 + Int($1.quantity) })
        }
        .tint(Constants.secondary)
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
