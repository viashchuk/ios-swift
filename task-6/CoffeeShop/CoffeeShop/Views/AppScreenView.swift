//
//  AppScreenView.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//


import SwiftUI

struct AppScreenView: View {
    let name: String
    let email: String
    
    @EnvironmentObject var viewModel: LoginViewModel
    @StateObject private var appViewModel = AppScreenViewModel()
    
    @State private var cardNumber = ""
    @State private var cardHolderName = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Welcome, \(name)!")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top)
                
                if let order = appViewModel.order {
                    if order.status == .initialized {
                        if appViewModel.isLoading {
                            ProgressView()
                                .padding()
                        } else if let order = appViewModel.order {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Your Order")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Order ID: #\(order.id)")
                                        .font(.headline)
                                    Text("Status: \(order.status)")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                    
                                    if let orderItems = order.items, !orderItems.isEmpty {
                                        Divider()
                                            .padding(.vertical, 8)
                                        
                                        Text("Items:")
                                            .font(.headline)
                                            .padding(.top, 4)
                                        
                                        ForEach(orderItems, id: \.id) { item in
                                            HStack {
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(item.product?.name ?? "Unknown Product")
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                    Text("Quantity: \(item.quantity)")
                                                        .font(.caption)
                                                        .foregroundColor(.gray)
                                                }
                                                Spacer()
                                                Text("$\(String(format: "%.2f", item.price))")
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                            }
                                            .padding(.vertical, 4)
                                        }
                                        
                                        Divider()
                                            .padding(.vertical, 8)
                                        
                                        let total = orderItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
                                        HStack {
                                            Text("Total:")
                                                .font(.headline)
                                            Spacer()
                                            Text("$\(String(format: "%.2f", total))")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(Constants.primary)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            .padding(.horizontal)
                        } else if let errorMessage = appViewModel.errorMessage {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            Text("No order found")
                                .foregroundColor(.gray)
                                .padding()
                        }
                        
                        if appViewModel.order != nil {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Payment Information")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                VStack(spacing: 16) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Card Number")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        TextField("1234 5678 9012 3456", text: $cardNumber)
                                            .textFieldStyle(.roundedBorder)
                                            .keyboardType(.numberPad)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Cardholder Name")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        TextField("John Doe", text: $cardHolderName)
                                            .textFieldStyle(.roundedBorder)
                                    }
                                    
                                    HStack(spacing: 16) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("Expiry Date")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            TextField("MM/YY", text: $expiryDate)
                                                .textFieldStyle(.roundedBorder)
                                                .keyboardType(.numberPad)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("CVV")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            TextField("123", text: $cvv)
                                                .textFieldStyle(.roundedBorder)
                                                .keyboardType(.numberPad)
                                        }
                                    }
                                    
                                    Button {
                                        Task {
                                            await appViewModel.processPayment(
                                                cardNumber: cardNumber,
                                                expiryDate: expiryDate,
                                                cvv: cvv,
                                                cardholderName: cardHolderName
                                            )
                                        }
                                    } label: {
                                        HStack {
                                            if appViewModel.isLoading {
                                                ProgressView().tint(.white)
                                            } else {
                                                Text("Complete Payment")
                                                    .fontWeight(.bold)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.primary)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            .padding(.horizontal)
                        }
                    }
                    else if order.status == .completed {
                            // ПОКАЗЫВАЕМ СООБЩЕНИЕ ОБ УСПЕХЕ
                            VStack(spacing: 12) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 50))
                                Text("Order Paid!")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                }
                
                Spacer()
                
                Button(role: .destructive) {
                    viewModel.logout()
                } label: {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .task {
            await appViewModel.fetchInitializedOrder()
        }
    }
}

