//
//  AppViewModel.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 31/01/2026.
//

import Combine
import Foundation

struct CategoriesResponse: Codable {
    let success: Bool
    let categories: [CategoryDTO]
    let error: String?
}

struct ProductsResponse: Codable {
    let success: Bool
    let products: [ProductDTO]
    let error: String?
}

class AppViewModel: ObservableObject {
    @Published var isSyncing = false

    func startSync() async {
        
        print("START SYNC")
        
        guard DataSyncService.shared.shouldSync() else {
            print("FRESH DATA")
            return
        }

        await MainActor.run { isSyncing = true }

        do {
            async let categoriesTask: CategoriesResponse = NetworkService.shared
                .performRequest(endpoint: "/categories")

            async let productsTask: ProductsResponse = NetworkService.shared
                .performRequest(endpoint: "/products")
//            async let ordersTask: [OrderDTO] = NetworkService.shared
//                .performRequest(endpoint: "/orders", requiresAuth: true)
            
            let categoriesResponse = try await categoriesTask
            let categories = categoriesResponse.categories
            
            
            let productsResponse = try await productsTask
            let products = productsResponse.products

            let fullResponse = SyncResponse(
                        categories: categories,
                        products: products
                    )
            
            print("SEND TO CORE")

            DataSyncService.shared.syncEverything(from: fullResponse)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }

        await MainActor.run { isSyncing = false }
    }
}

