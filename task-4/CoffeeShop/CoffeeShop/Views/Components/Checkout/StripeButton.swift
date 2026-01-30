//
//  StripeButton.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import SwiftUI
import StripePaymentSheet

struct StripeButton: View {
    @ObservedObject var viewModel: CheckoutViewModel
    let paymentSheet: PaymentSheet
    
    var body: some View {
        PaymentSheet.PaymentButton(
            paymentSheet: paymentSheet,
            onCompletion: viewModel.handlePaymentResult
        ) {
            HStack {
                Spacer()
                if viewModel.isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text("Pay via Stripe $\(viewModel.order?.totalAmount ?? 0, specifier: "%.2f")")
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .padding()
            .background(Constants.primary)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}
