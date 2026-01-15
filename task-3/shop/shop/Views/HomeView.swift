//
//  HomeView.swift
//  shop
//
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    
    @State private var selectedCategory: Category? = nil
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
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
                    categories: categories,
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
        .background(Color.gray.opacity(0.05))
        .navigationDestination(for: Product.self) { product in
            ProductDetailView(product: product)
        }
    }
    
    private var filteredProducts: [Product] {
        guard let selected = selectedCategory else { return Array(products) }
        return products.filter { $0.category == selected }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

