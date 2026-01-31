//
//  ProductDetailView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

//
//import SwiftUI
//import CoreData
//
//struct ProductDetailView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.dismiss) private var dismiss
//    
//    @FetchRequest private var cartItems: FetchedResults<CartItem>
//    
//    @State private var selectedQuantity: Int = 1
//    
//    let product: Product
//    
//    init(product: Product) {
//        self.product = product
//        _cartItems = FetchRequest<CartItem>(
//            entity: CartItem.entity(),
//            sortDescriptors: [],
//            predicate: NSPredicate(format: "product == %@", product)
//        )
//    }
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            ScrollView {
//                VStack(alignment: .leading) {
//                    ZStack {
//                        Circle()
//                            .fill(Constants.primary)
//                            .frame(width: 220, height: 220)
//                            .shadow(color: .green.opacity(0.3),
//                                    radius: 8,
//                                    x: 0,
//                                    y: 4)
//                        
//                        if let imageName = product.imageName, !imageName.isEmpty {
//                            Image(imageName)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(height: 600)
//                                .offset(y: -40)
//                        } else {
//                            Image(systemName: "photo")
//                                .font(.system(size: 80))
//                                .foregroundColor(.gray)
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 350)
//                    .padding(.top, 20)
//                    
//                    VStack(alignment: .leading, spacing: 8) {
//                        HStack(alignment: .top) {
//                            Text(product.name ?? "Coffee")
//                                .font(.system(size: 30, weight: .bold))
//                                .fixedSize(horizontal: false, vertical: true)
//                            
//                            Spacer()
//                            
//                            VStack(alignment: .trailing) {
//                                Text("$\(product.price, specifier: "%.2f")")
//                                    .font(.system(size: 32, weight: .bold))
//                                    .foregroundColor(Constants.primary)
//                            }
//                        }
//                        
//                        Text("Description")
//                            .font(.headline)
//                            .padding(.top, 10)
//                        
//                        Text(product.details ?? "No description yet")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                            .lineSpacing(4)
//                    }
//                    .padding(.horizontal, 25)
//                }
//            }
//            
//            VStack {
//                Divider()
//                HStack(spacing: 20) {
//                    QuantityStepper(quantity: $selectedQuantity)
//                    
//                    Button(action: {
//                        addOrUpdateCart()
//                    }) {
//                        Text(cartItems.isEmpty ? "Add to Order" : "In Cart")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 55)
//                            .background(Color(red: 0.1, green: 0.4, blue: 0.3))
//                            .cornerRadius(30)
//                    }
//                }
//                .padding(.horizontal, 25)
//                .padding(.top, 15)
//                .padding(.bottom, 30)
//            }
//            .background(Color.white)
//        }
//        .ignoresSafeArea(edges: .bottom)
//        .toolbar(.hidden, for: .tabBar)
//        .onAppear {
//            if let item = cartItems.first {
//                selectedQuantity = Int(item.quantity)
//            }
//        }
//    }
//    
//    private func addOrUpdateCart() {
//        if let item = cartItems.first {
//            item.quantity = Int16(selectedQuantity)
//        } else {
//            let newItem = CartItem(context: viewContext)
//            newItem.id = UUID()
//            newItem.quantity = Int16(selectedQuantity)
//            newItem.product = product
//        }
//        saveContext()
//    }
//    
//    private func saveContext() {
//        try? viewContext.save()
//    }
//}
//
//
//#Preview {
//    let context = PersistenceController.shared.container.viewContext
//    let previewProduct = Product(context: context)
//    previewProduct.name = "Caramel Frappuccino"
//    previewProduct.price = 30.00
//    previewProduct.details = "Our signature Caramel Frappuccino® blended beverage is a blend of coffee, milk and ice with caramel syrup, topped with whipped cream and a swirl of caramel sauce."
//    previewProduct.imageName = "caramel_brulee_frappuccino"
//    
//    return NavigationView {
//        ProductDetailView(product: previewProduct)
//            .environment(\.managedObjectContext, context)
//    }
//}
