//
//  OrderSummary.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import SwiftUI

struct OrderSummary: View {
    let order: OrderEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Order")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(alignment: .leading, spacing: 8) {
                if let orderItems = order.orderItems as? Set<OrderItemEntity> {
                    let orderItemsArray = orderItems.sorted { $0.id < $1.id }
                    Divider()
                        .padding(.vertical, 8)
                    
                    Text("Items:")
                        .font(.headline)
                        .padding(.top, 4)
                    
                    ForEach(orderItemsArray, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.product?.name ?? "Unknown Product")
                                    .font(.body)
                                    .fontWeight(.medium)
                                Text("Quantity: \(item.quantity)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("$\(String(format: "%.2f", item.price))")
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 4)
                    }
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    let total = orderItemsArray.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
                    HStack {
                        Text("Total:")
                            .font(.headline)
                        Spacer()
                        Text("$\(String(format: "%.2f", total))")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Constants.primary)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }.padding(.horizontal)
    }
}

