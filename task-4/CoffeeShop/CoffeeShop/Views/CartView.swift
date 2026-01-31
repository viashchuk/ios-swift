//
//  CartView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import SwiftUI
import CoreData
//
//struct CartView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @FetchRequest(
//        sortDescriptors: [],
//        animation: .default)
//    private var cartItems: FetchedResults<CartItem>
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            HStack {
//                Spacer()
//                Text("My Cart")
//                    .font(.system(size: 24))
//                    .fontWeight(.bold)
//                    .foregroundColor(Constants.secondary)
//                    .multilineTextAlignment(.center)
//                Spacer()
//            }
//            .padding(.vertical, 20)
//            List {
//                ForEach(cartItems) { item in
//                    CartRow(item: item)
//                        .listRowSeparator(.hidden)
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .listStyle(.plain)
//            .scrollContentBackground(.hidden)
//            
//            if !cartItems.isEmpty {
//                OrderSummary(cartItems: cartItems)
//                    .id(cartItems.map { "\($0.objectID)-\($0.quantity)" }.joined())
//            }
//        }
//    }
//    
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { cartItems[$0] }.forEach(viewContext.delete)
//            try? viewContext.save()
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
//    return NavigationStack {
//        CartView().environment(\.managedObjectContext, context)
//    }
//}
