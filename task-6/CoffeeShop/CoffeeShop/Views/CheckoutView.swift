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

struct CheckoutView: View {
    @StateObject private var appViewModel = CheckoutViewModel()
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: 24) {
                    if let order = appViewModel.order {
                        if order.status == .initialized {
                            OrderSummary(order: order)
                            PaymentForm(appViewModel: appViewModel)
                        } else {
                            PurchaseComplete(onBackToHome: {
                                navigationPath.append(NavigationDestination.ordersHistory)
                            })
                        }
                    } else {
                        Text("You don't have initialized oreders")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding()
            }
            .task {
                await appViewModel.fetchInitializedOrder()
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .ordersHistory:
                    OrdersHistoryView()
                }
            }
        }
    }
}
