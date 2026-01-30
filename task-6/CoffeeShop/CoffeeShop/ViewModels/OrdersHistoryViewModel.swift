//
//  OrdersHistoryViewModel.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import Combine
import Foundation

@MainActor
class OrdersHistoryViewModel: ObservableObject {
    @Published var purchasedOrders: [Order] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchHistory() async {
        isLoading = true
        errorMessage = nil

        do {
            let response: OrderResponse = try await NetworkService.shared
                .performRequest(
                    endpoint: "/orders",
                    method: "GET",
                    queryParameters: ["status": "completed"],
                    requiresAuth: true
                )
            self.purchasedOrders = response.orders
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    private func handleError(_ error: Error) {
        if let reqError = error as? RequestError {
            errorMessage = reqError.description
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
