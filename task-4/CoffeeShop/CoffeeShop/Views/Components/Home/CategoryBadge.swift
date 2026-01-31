//
//  CategoryBadge.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import SwiftUI

struct CategoryBadge: View {
    let name: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(name)
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isActive ? Constants.secondary : .white)
                .foregroundColor(isActive ? .white : .primary)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isActive ? Color.clear : Constants.secondary, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        VStack(spacing: 20) {
            CategoryBadge(name: "All Coffee", isActive: true) {
                print("Active tapped")
            }
            CategoryBadge(name: "Frappuccino", isActive: false) {
                print("Inactive tapped")
            }
        }
    }
}
