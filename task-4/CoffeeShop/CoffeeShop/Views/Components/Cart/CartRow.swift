//
//  CartRow.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import SwiftUI
import CoreData
//
//struct CartRow: View {
//    @ObservedObject var item: CartItem
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack(spacing: 12) {
//                if let imageName = item.product?.imageName, !imageName.isEmpty {
//                    Image(imageName)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 60, height: 60)
//                        .cornerRadius(10)
//                } else {
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(Color.secondary.opacity(0.1))
//                        .frame(width: 60, height: 60)
//                        .overlay(Image(systemName: "cup.and.saucer").foregroundColor(.gray))
//                }
//                
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(item.product?.name ?? "Coffee")
//                        .font(.headline)
//                    
//                    Text("\(item.product?.price ?? 0, specifier: "%.2f") $")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
//                
//                Spacer()
//                
//                QuantityStepper(quantity: Binding(
//                    get: { Int(item.quantity) },
//                    set: { newValue in
//                        item.quantity = Int16(newValue)
//                        try? item.managedObjectContext?.save()
//                    }
//                ))
//            }
//            .padding(.vertical, 16)
//            
//            Divider()
//        }
//    }
//}
//
//#Preview {
//    let context = PersistenceController.shared.container.viewContext
//    let previewProduct = Product(context: context)
//    previewProduct.name = "Caramel Frappuccino"
//    previewProduct.price = 30.00
//    previewProduct.imageName = "caramel_brulee_frappuccino"
//    
//    let previewCartItem = CartItem(context: context)
//    previewCartItem.product = previewProduct
//    previewCartItem.quantity = 2
//    
//    return List {
//        CartRow(item: previewCartItem)
//    }
//    .listStyle(.plain)
//}
