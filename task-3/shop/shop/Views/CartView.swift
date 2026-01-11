//
//  CartView.swift
//  shop
//
//

import SwiftUI
import CoreData

struct CartView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var cartItems: FetchedResults<CartItem>
    
    var body: some View {
        NavigationView {
                    List {
                        if cartItems.isEmpty {
                            Text("Your cart is empty")
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(cartItems) { item in
                                HStack {
                                    Text(item.product?.name ?? "Coffee")
                                    Spacer()
                                    Text("x\(item.quantity)")
                                    Text("\(Double(item.quantity) * (item.product?.price ?? 0), specifier: "%.2f") $")
                                        .bold()
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                    .navigationTitle("Cart")
                }
    }
    
    private func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { cartItems[$0] }.forEach(viewContext.delete)
                try? viewContext.save()
            }
        }
}

#Preview {
    CartView()
}
