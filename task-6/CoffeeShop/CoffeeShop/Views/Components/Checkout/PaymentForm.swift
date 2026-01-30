//
//  PaymentForm.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import SwiftUI

struct PaymentForm: View {
    @ObservedObject var appViewModel: CheckoutViewModel
    
    @State private var cardNumber = ""
    @State private var cardHolderName = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    
    var body: some View {
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
                
                if let errorMessage = appViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
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
