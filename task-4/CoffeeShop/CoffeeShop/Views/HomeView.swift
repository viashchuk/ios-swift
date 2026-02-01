//
//  HomeView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import CoreData
import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
        ],
        animation: .default
    )
    private var categories: FetchedResults<CategoryEntity>

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
        ],
        animation: .default
    )
    private var products: FetchedResults<ProductEntity>

    @State private var selectedCategory: CategoryEntity? = nil
    @State private var isShowingAddProduct = false

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Text("Coffee Shop")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(Constants.secondary)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.vertical, 20)

                CategoryList(
                    categories: Array(categories),
                    selectedCategory: $selectedCategory
                )

                VStack(alignment: .leading) {

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredProducts) { product in
                            NavigationLink(value: product) {
                                ProductGridItem(product: product)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }

            }
            .padding(.bottom, 60)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingAddProduct = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Constants.secondary)
                }
            }
        }
        .sheet(isPresented: $isShowingAddProduct) {
            AddProductView()
        }
        .background(Color.gray.opacity(0.05))
        //        .navigationDestination(for: ProductEntity.self) { product in
        //            ProductDetailView(product: product)
        //        }
    }

    private var filteredProducts: [ProductEntity] {
        guard let selected = selectedCategory else { return Array(products) }
        return products.filter { $0.category == selected }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
