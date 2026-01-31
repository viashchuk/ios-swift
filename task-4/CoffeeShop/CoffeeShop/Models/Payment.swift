//
//  Payment.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 31/01/2026.
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
            "cardNumber": cardNumber,
            "cardholderName": cardholderName,
            "expiryDate": expiryDate,
            "cvv": cvv
        ]
    }
}
