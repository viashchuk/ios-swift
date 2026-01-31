//
//  OrdersHistoryView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import SwiftUI
//
//struct OrdersHistoryView: View {
//    @StateObject private var historyViewModel = OrdersHistoryViewModel()
//    
//    var body: some View {
//        Group {
//            if historyViewModel.isLoading {
//                ProgressView("Loading history...")
//            } else if historyViewModel.purchasedOrders.isEmpty {
//                Text("You haven't purchased anything yet.")
//                    .foregroundColor(.gray)
//            } else {
//                List(historyViewModel.purchasedOrders) { order in
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Order #\(order.id)")
//                            .fontWeight(.bold)
//                        if let items = order.items {
//                            ForEach(items, id: \.id) { item in
//                                HStack {
//                                    Text(item.product?.name ?? "Product")
//                                        .font(.subheadline)
//                                    Spacer()
//                                    Text("\(item.quantity) x $\(item.price)")
//                                        .font(.caption)
//                                }
//                            }
//                        }
//                    }
//                    .padding(.vertical, 4)
//                }
//            }
//        }
//        .navigationTitle("Order History")
//        .task {
//            await historyViewModel.fetchHistory()
//        }
//    }
//}
