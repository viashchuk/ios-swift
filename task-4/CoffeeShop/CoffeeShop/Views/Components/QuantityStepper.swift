//
//  QuantityStepper.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import SwiftUI
//
//struct QuantityStepper: View {
//    @Binding var quantity: Int
//    
//    var body: some View {
//        HStack {
//            Button(action: {
//                if quantity > 1 { quantity -= 1 }
//            }) {
//                Image(systemName: "minus")
//                    .font(.system(size: 14, weight: .bold))
//                    .foregroundColor(quantity > 1 ? .white : Constants.secondary)
//                    .frame(width: 36, height: 36)
//                    .background(quantity > 1 ? Constants.secondary : Constants.secondary.opacity(0.2))
//                    .clipShape(Circle())
//            }
//            
//            Text("\(quantity)")
//                .font(.headline)
//                .frame(width: 30)
//            
//            Button(action: {
//                quantity += 1
//            }) {
//                Image(systemName: "plus")
//                    .font(.system(size: 14, weight: .bold))
//                    .foregroundColor(.white)
//                    .frame(width: 36, height: 36)
//                    .background(Constants.secondary)
//                    .clipShape(Circle())
//            }
//        }
//        .buttonStyle(.plain)
//        .padding(6)
//        .background(Color.gray.opacity(0.1))
//        .cornerRadius(30)
//    }
//}
//
//
//#Preview {
//    @Previewable @State var selectedQuantity: Int = 1
//    
//    ZStack {
//        VStack(spacing: 20) {
//            QuantityStepper(quantity: $selectedQuantity)
//        }
//    }
//}
//
