//
//  CheckoutView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import Combine
import SwiftUI

enum NavigationDestination: Hashable {
    case ordersHistory
}
//
//struct CheckoutView: View {
//    @StateObject private var viewModel = CheckoutViewModel()
//    @State private var navigationPath = NavigationPath()
//
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            ScrollView {
//                VStack(spacing: 24) {
//                    if let order = viewModel.order {
//                        if order.status == .initialized {
//                            OrderSummary(order: order)
//                            PaymentForm(viewModel: viewModel)
//                        } else {
//                            PurchaseComplete(onBackToHome: {
//                                navigationPath.append(NavigationDestination.ordersHistory)
//                            })
//                        }
//                    } else {
//                        Text("You don't have initialized orders")
//                            .foregroundColor(.gray)
//                            .padding()
//                    }
//                }
//                .padding()
//            }
//            .task {
//                await viewModel.fetchInitializedOrder()
//            }
//            .navigationDestination(for: NavigationDestination.self) { destination in
//                switch destination {
//                case .ordersHistory:
//                    OrdersHistoryView()
//                }
//            }
//        }
//    }
//}
