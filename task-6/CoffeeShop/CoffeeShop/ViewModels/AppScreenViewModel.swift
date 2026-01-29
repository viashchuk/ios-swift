//
//  AppScreenViewModel.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//

import Foundation
import Combine

@MainActor
class AppScreenViewModel: ObservableObject {
    @Published var order: Order?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchInitializedOrder() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response: OrderResponse = try await NetworkService.shared.performRequest(
                endpoint: "/orders",
                method: "GET",
                queryParameters: ["status": "initialized"],
                requiresAuth: true
            )
            
            print(response)
            
            self.order = response.orders.first
        } catch {
            handleError(error)
        }
        
        isLoading = false
    }
    
    func processPayment(cardNumber: String, expiryDate: String, cvv: String, cardholderName: String) async {
        guard let order = order else { return }
        
        isLoading = true
        errorMessage = nil
        
        let paymentBody: [String: Any] = [
            "cardNumber": cardNumber,
            "expiryDate": expiryDate,
            "cvv": cvv,
            "cardholderName": cardholderName,
            "amount": order.totalAmount,
        ]
        
        do {
            let response: PaymentResponse = try await NetworkService.shared.performRequest(
                endpoint: "/orders/\(order.id)/pay",
                method: "POST",
                body: paymentBody,
                requiresAuth: true
            )
            
            if response.success {
                self.order = response.order
                print("Success: \(response.message ?? "")")
            } else {
                self.errorMessage = response.error
            }
        } catch {
            handleError(error)
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

