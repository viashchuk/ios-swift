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
    
        var body: some View {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Shop", systemImage: "house")
                        }
                    CartView()
                        .tabItem {
                            Label("Cart", systemImage: "cart")
                        }
                }
            }
        }

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
