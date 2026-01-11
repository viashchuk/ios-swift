//
//  ProductDetailView.swift
//  shop
//
//

import SwiftUI
import CoreData

struct ProductDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest private var cartItems: FetchedResults<CartItem>
    
    
    let product: Product
    
    init(product: Product) {
            self.product = product
            _cartItems = FetchRequest<CartItem>(
                entity: CartItem.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(format: "product == %@", product)
            )
        }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let imageName = product.imageName, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(15)
                } else {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.1))
                        .frame(height: 300)
                        .overlay(Image(systemName: "photo").font(.largeTitle))
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text(product.name ?? "Coffee")
                        .font(.largeTitle)
                        .bold()

                    Text("\(product.price, specifier: "%.2f") $")
                        .font(.title2)
                        .foregroundColor(.green)
                        .fontWeight(.semibold)

                    Divider()

                    Text("Description")
                        .font(.headline)

                    Text(product.details ?? "We don't have description yet")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    if let cartItem = cartItems.first {
                        HStack(spacing: 20) {
                            Button(action: { changeQuantity(item: cartItem, delta: -1) }) {
                                Image(systemName: "minus.circle.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(.red)
                            }

                            Text("\(cartItem.quantity)")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(minWidth: 40)

                            Button(action: { changeQuantity(item: cartItem, delta: 1) }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(.green)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                        } else {
                            Button(action: addToCart) {
                                Label("Add to Cart", systemImage: "cart.badge.plus")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("About drink")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addToCart() {
        let newItem = CartItem(context: viewContext)
        newItem.id = UUID()
        newItem.quantity = 1
        newItem.product = product
        saveContext()
    }
    
    private func changeQuantity(item: CartItem, delta: Int16) {
        let newQuantity = item.quantity + delta
        if newQuantity > 0 {
            item.quantity = newQuantity
        } else {
            viewContext.delete(item)
        }
        saveContext()
    }

    private func saveContext() {
        try? viewContext.save()
    }
}
