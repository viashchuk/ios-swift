//
//  PurchaseComplete.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import SwiftUI

struct PurchaseComplete: View {
    @Environment(\.dismiss) var dismiss
    var onBackToHome: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Constants.primary)
                    .frame(width: 100, height: 100)
                
                Image(systemName: "checkmark")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
            }
            
            VStack(spacing: 12) {
                Text("Purchase Complete!")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
            }
            
            Spacer()
            Spacer()
            
            Button {
                onBackToHome()
            } label: {
                Text("Back to home")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Constants.secondary)
                    .cornerRadius(28)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color(.systemBackground))
    }
}
