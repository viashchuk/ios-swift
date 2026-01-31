//
//  CoffeeShopApp.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import StripePaymentSheet
import SwiftUI
import CoreData

@main
struct CoffeeShopApp: App {
    init() {
        StripeAPI.defaultPublishableKey =
            "pk_test_51RcQK3P3coCkPuVXX1xPqRjr1zqmCQoZF384HTnOBSxyyQJIEUNN1jFKYg6fnQ5QCw5Hnu4OnLjCZmRZJIcMcmBE00fVGaEaW2"
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL { url in
                StripeAPI.handleURLCallback(with: url)
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
