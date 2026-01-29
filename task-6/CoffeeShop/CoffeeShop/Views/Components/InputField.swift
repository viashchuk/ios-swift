//
//  InputField.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//


import SwiftUI

struct InputField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isPassword: Bool = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading) {
                Spacer()
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .frame(width: 30)
                Spacer()
            }
            .padding(.horizontal, 12)
            .background(Constants.primary)
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 16,
                    bottomLeadingRadius: 16,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                )
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(placeholder)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                if isPassword {
                    SecureField("", text: $text)
                        .autocapitalization(.none)
                        .focused($isFocused)
                } else {
                    TextField("", text: $text)
                        .focused($isFocused)
                        .autocapitalization(.none)
                        .keyboardType(placeholder.contains("Email") ? .emailAddress : .default)
                }
            }
        }
        .padding(.trailing, 20)
        .frame(height: 70)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isFocused ? Constants.primary : Color.gray.opacity(0.5),
                )
        )
    }
}

#Preview {
    InputField(
        icon: "envelope",
        placeholder: "Email Address",
        text: .constant("vicky@example.com")
    )
}
