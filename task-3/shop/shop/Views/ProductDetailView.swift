//
//  ProductDetailView.swift
//  shop
//
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

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
                }
                .padding()
            }
        }
        .navigationTitle("About drink")
        .navigationBarTitleDisplayMode(.inline)
    }
}
