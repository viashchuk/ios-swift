//
//  CartView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import CoreData
import SwiftUI
import Combine

struct CartView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingCheckout = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Text("My Cart")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(Constants.secondary)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.vertical, 20)
            if let currentOrder = appViewModel.currentOrder,
                let items = currentOrder.orderItems?.allObjects
                    as? [OrderItemEntity],
                !items.isEmpty
            {

                List {
                    ForEach(
                        items.sorted(by: {
                            ($0.product?.name ?? "") < ($1.product?.name ?? "")
                        })
                    ) { item in
                        CartRow(item: item)
                            .listRowSeparator(.hidden)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 8,
                                    leading: 16,
                                    bottom: 8,
                                    trailing: 16
                                )
                            )
                    }
                    .onDelete { offsets in
                        deleteItems(offsets: offsets, from: items)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)

                CartOrderSummary() {
                    showingCheckout = true
                }
            } else {
                Text("You don't have any products in your cart")
            }
        }.sheet(isPresented: $showingCheckout) {
            CheckoutView()
        }
    }

    private func deleteItems(offsets: IndexSet, from items: [OrderItemEntity]) {
            let sortedItems = items.sorted(by: { ($0.product?.name ?? "") < ($1.product?.name ?? "") })
            withAnimation {
                offsets.map { sortedItems[$0] }.forEach(viewContext.delete)
                try? viewContext.save()
                appViewModel.objectWillChange.send()
            }
        }
}
