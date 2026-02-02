//
//  CartOrderSummary.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import SwiftUI

struct CartOrderSummary: View {
    @EnvironmentObject var viewModel: AppViewModel
    var onPlaceOrder: () -> Void

    var body: some View {
        let items =
            viewModel.currentOrder?.orderItems?.allObjects as? [OrderItemEntity]
            ?? []
        let totalPrice = items.reduce(0) {
            $0 + (Double($1.quantity) * $1.price)
        }
        let totalQuantity = items.reduce(0) { $0 + Int($1.quantity) }

        VStack(spacing: 15) {
            HStack {
                Text("Total Items")
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(items.reduce(0) { $0 + Int($1.quantity) })")
                    .fontWeight(.semibold)
            }

            HStack {
                Text("Total Amount")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Text("\(totalPrice, specifier: "%.2f") $")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.secondary)
                    .contentTransition(.numericText())
            }

            Button(action: {
                onPlaceOrder()
            }) {
                Text("Place Order")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Constants.secondary)
                    .cornerRadius(15)
            }
            .padding(.top, 10)
        }
        .padding(20)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 10, y: -5)
    }
}
