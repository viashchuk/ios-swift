//
//  ContentView.swift
//  shop
//
//  Created by Victoria Iashchuk on 11/12/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    HStack {
                        if let imageName = product.imageName, !imageName.isEmpty {
                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .clipped()
                                .cornerRadius(12)
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.secondary.opacity(0.2))
                                .frame(width: 70, height: 70)
                                .overlay(Image(systemName: "cart.fill").foregroundColor(.gray))
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(product.name ?? "Coffee")
                                .font(.headline)
                                .foregroundColor(.primary)
                            if let categoryName = product.category?.name {
                                Text(categoryName)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                            
                            Text("\(product.price, specifier: "%.2f") $")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .navigationTitle("Мой список")
            
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
