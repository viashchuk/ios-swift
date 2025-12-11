//
//  shopApp.swift
//  shop
//
//  Created by Victoria Iashchuk on 11/12/2025.
//

import SwiftUI
import CoreData

@main
struct shopApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
