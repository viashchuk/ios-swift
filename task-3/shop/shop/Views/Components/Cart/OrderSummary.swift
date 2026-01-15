//
//  OrderSummary.swift
//  shop
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import SwiftUI

struct OrderSummary: View {
    let cartItems: FetchedResults<CartItem>
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Total Items")
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(cartItems.reduce(0) { $0 + Int($1.quantity) })")
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
            }
            
            Button(action: {}) {
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
    
    private var totalPrice: Double {
        cartItems.reduce(0) { $0 + (Double($1.quantity) * ($1.product?.price ?? 0)) }
    }
}
