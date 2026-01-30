//
//  CheckoutViewModel.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import Combine
import Foundation
import StripePaymentSheet

@MainActor
class CheckoutViewModel: ObservableObject {
    @Published var order: Order?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var paymentSheet: PaymentSheet?
    private var lastStripePaymentId: String?

    func fetchInitializedOrder() async {
        isLoading = true
        errorMessage = nil

        do {
            let response: OrderResponse = try await NetworkService.shared
                .performRequest(
                    endpoint: "/orders",
                    method: "GET",
                    queryParameters: ["status": "initialized"],
                    requiresAuth: true
                )

            print(response)

            self.order = response.orders.last
        } catch {
            handleError(error)
        }

        isLoading = false
    }

    func processPayment(
        cardNumber: String,
        expiryDate: String,
        cvv: String,
        cardholderName: String
    ) async {
        print("Start")
        guard let order = order else { return }

        isLoading = true
        errorMessage = nil

        let paymentData = Payment(
            orderId: order.id,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cvv: cvv,
            cardholderName: cardholderName,
            amount: order.totalAmount
        )

        let body: [String: Any] = paymentData.toDictionary()
        print(body)

        do {
            let response: PaymentResponse = try await NetworkService.shared
                .performRequest(
                    endpoint: "/orders/\(order.id)/pay",
                    method: "POST",
                    body: body,
                    requiresAuth: true
                )

            if response.success {
                self.order = response.order
            } else {
                self.errorMessage = response.error
            }
        } catch {
            handleError(error)
        }
        
        isLoading = false
    }
    
    func prepareStripePayment() async {
            guard let order = order else { return }
            
            isLoading = true
            errorMessage = nil

            do {
                let response: StripeIntentResponse = try await NetworkService.shared
                    .performRequest(
                        endpoint: "/orders/\(order.id)/stripe-pay",
                        method: "POST",
                        requiresAuth: true
                    )
                
                guard let clientSecret = response.clientSecret,
                      let stripeId = response.stripePaymentId else {
                    errorMessage = "Error stripe config"
                    return
                }

                self.lastStripePaymentId = stripeId

                var configuration = PaymentSheet.Configuration()
                configuration.merchantDisplayName = "Coffee Shop"
                
                configuration.returnURL = "coffeeshop://stripe-redirect"
                self.paymentSheet = PaymentSheet(
                    paymentIntentClientSecret: clientSecret,
                    configuration: configuration
                )
                
            } catch {
                handleError(error)
            }
            isLoading = false
        }

    func confirmOrderCompleted() async {
        guard let order = order else { return }
        guard let stripeId = lastStripePaymentId else { return }
        
        isLoading = true
        errorMessage = nil
        
        let body: [String: Any] = ["stripePaymentId": stripeId]

        do {
            let response: PaymentResponse = try await NetworkService.shared
                .performRequest(
                    endpoint: "/orders/\(order.id)/stripe-confirm",
                    method: "POST",
                    body: body,
                    requiresAuth: true
                )
            
            if response.success {
                self.order = response.order
                print("Order status was updated")
            } else {
                self.errorMessage = response.error
            }
        } catch {
            handleError(error)
        }
        isLoading = false
    }
    
    func handlePaymentResult(_ result: PaymentSheetResult) {
        switch result {
        case .completed:
            Task { await confirmOrderCompleted() }
        case .failed(let error):
            errorMessage = error.localizedDescription
        case .canceled:
            print("Payment was canceled")
        }
    }

    private func handleError(_ error: Error) {
        if let reqError = error as? RequestError {
            errorMessage = reqError.description
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
