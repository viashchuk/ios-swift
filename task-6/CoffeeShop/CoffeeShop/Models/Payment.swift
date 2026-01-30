//
//  Payment.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//

import Foundation

struct Payment {
    let orderId: Int
    let cardNumber: String
    let expiryDate: String
    let cvv: String
    let cardholderName: String
    let amount: Double

    var cardLast4: String {
        String(cardNumber.suffix(4))
    }

    func toDictionary() -> [String: Any] {
        return [
            "cardLast4": cardLast4,
            "cardholderName": cardholderName,
            "amount": amount,
            "currency": "USD",
        ]
    }
}
