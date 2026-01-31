//
//  ProductGridItem.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import SwiftUI

struct ProductGridItem: View {
    let product: ProductEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack() {
                Spacer()
                if let imageUrl = product.imageUrl, !imageUrl.isEmpty {
                    AsyncImage(url: URL(string: Constants.baseServerURL + imageUrl)) { image in
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
                    Rectangle()
                        .fill(Color.secondary.opacity(0.1))
                        .frame(height: 150)
                        .overlay(Image(systemName: "photo").foregroundColor(.gray))
                }
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(product.name!)
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

}

