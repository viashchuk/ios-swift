//
//  ProductDetailView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import SwiftUI
import CoreData

struct ProductDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var appViewModel: AppViewModel
    
    @State private var selectedQuantity: Int = 1
    let product: ProductEntity
    
    private var existingItem: OrderItemEntity? {
        let items = appViewModel.currentOrder?.orderItems?.allObjects as? [OrderItemEntity]
        return items?.first(where: { $0.product?.id == product.id })
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        Circle()
                            .fill(Constants.primary.opacity(0.2))
                            .frame(width: 220, height: 220)
                        
                        if let imageName = product.imageUrl, !imageName.isEmpty {
                            AsyncImage(url: URL(string: Constants.baseServerURL + imageName)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.secondary.opacity(0.1))
                                    .overlay(Image(systemName: "photo").foregroundColor(.gray))
                            }
                            .frame(height: 150)
                        } else {
                            Image(systemName: "cup.and.saucer.fill")
                                .font(.system(size: 80))
                                .foregroundColor(Constants.primary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top) {
                            Text(product.name ?? "Coffee")
                                .font(.system(size: 28, weight: .bold))
                            Spacer()
                            Text("$\(product.price, specifier: "%.2f")")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Constants.secondary)
                        }
                        
                        Text("Description")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        Text(product.details ?? "No description available")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 25)
                }
            }
            
            VStack {
                Divider()
                HStack(spacing: 20) {
                    if let item = existingItem {
                        QuantityStepper(
                            quantity: Binding(
                                get: { Int(item.quantity) },
                                set: { newValue in
                                    item.quantity = Int16(newValue)
                                    saveAndRefresh()
                                }
                            )
                        )
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    } else {
                        Button(action: {
                            addToCart()
                        }) {
                            Text("Add to Order")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(Constants.secondary)
                                .cornerRadius(30)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .animation(.spring(), value: existingItem)
                .padding(.horizontal, 25)
                .padding(.top, 15)
                .padding(.bottom, 40)
            }
            .background(Color(.systemBackground))
        }
        .ignoresSafeArea(edges: .bottom)
        .toolbar(.hidden, for: .tabBar)
    }
        
    private func addToCart() {
        guard let order = appViewModel.currentOrder else { return }
        
        let newItem = OrderItemEntity(context: viewContext)
        newItem.id = Int64(Date().timeIntervalSince1970)
        newItem.quantity = 1
        newItem.price = product.price
        newItem.product = product
        newItem.order = order
        
        saveAndRefresh()
    }
    
    private func saveAndRefresh() {
        try? viewContext.save()
        appViewModel.refreshCart()
    }
}
