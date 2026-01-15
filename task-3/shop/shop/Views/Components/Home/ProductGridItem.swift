//
//  ProductGridItem.swift
//  shop
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import SwiftUI
import CoreData

struct ProductGridItem: View {
    @ObservedObject var product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack() {
                Spacer()
                if let imageName = product.imageName, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                } else {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.1))
                        .frame(height: 150)
                        .overlay(Image(systemName: "photo").foregroundColor(.gray))
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(product.name ?? "Product")
                    .font(.headline)
                    .lineLimit(1)
                
                Text("\(product.price, specifier: "%.2f") $")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Constants.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(Color(.white))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    let previewProduct = Product(context: context)
    previewProduct.name = "Caramel Frappuccino"
    previewProduct.price = 30.00
    previewProduct.imageName = "caramel_brulee_frappuccino"
    
    return Group {
        ProductGridItem(product: previewProduct)
            .frame(width: 170)
            .padding()
    }
}
