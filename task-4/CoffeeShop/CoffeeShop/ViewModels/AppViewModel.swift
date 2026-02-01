//
//  AppViewModel.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 31/01/2026.
//

import Combine
import CoreData
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

struct OrdersResponse: Codable {
    let success: Bool
    let orders: [OrderDTO]
    let error: String?
}

class AppViewModel: ObservableObject {
    @Published var isSyncing = false
    @Published var currentOrder: OrderEntity?

    private let context = PersistenceController.shared.container.viewContext

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
            async let ordersTask: OrdersResponse = NetworkService.shared
                .performRequest(endpoint: "/orders", requiresAuth: true)

            let (categoriesResponse, productsResponse, ordersResponse) = try
                await (categoriesTask, productsTask, ordersTask)

            let fullResponse = SyncResponse(
                categories: categoriesResponse.categories,
                products: productsResponse.products,
                orders: ordersResponse.orders
            )

            print("SEND TO CORE")

            DataSyncService.shared.syncEverything(from: fullResponse)

            //            await setupCurrentOrder()
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }

        await MainActor.run { isSyncing = false }
    }

    private func setupCurrentOrder() {
        let request = OrderEntity.fetchRequest()

        do {
            let allOrders = try context.fetch(request)

            self.currentOrder = DataSyncService.shared
                .fetchOrCreateCurrentOrder(from: allOrders, in: context)
            print("CURRENT ORDER: ID \(self.currentOrder?.id ?? 0)")
        } catch {
            print("Failed to fetch orders: \(error)")
        }
    }
}
