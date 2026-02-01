//
//  OrdersHistoryView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import SwiftUI
import CoreData

struct OrdersHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \OrderEntity.purchasedAt, ascending: false)],
        predicate: NSPredicate(format: "status == %@", "completed"),
        animation: .default)
    private var orders: FetchedResults<OrderEntity>
    
    var body: some View {
        List {
            ForEach(orders) { order in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Order #\(order.id)")
                        .fontWeight(.bold)
                    
                    if let orderItems = order.orderItems as? Set<OrderItemEntity> {
                        ForEach(Array(orderItems), id: \.objectID) { item in
                            HStack {
                                Text(item.product?.name ?? "Product")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(item.quantity) x $\(item.price, specifier: "%.2f")")
                                    .font(.caption)
                            }
                        }
                    }
                    
                    if let purchasedAt = order.purchasedAt {
                        Text("Date: \(purchasedAt, style: .date)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Text("Total: $\(order.totalAmount, specifier: "%.2f")")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top, 4)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("My Orders")
    }
}
