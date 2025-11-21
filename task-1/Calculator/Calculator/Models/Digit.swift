//
//  Digit.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//

enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    
    var description: String {
        "\(rawValue)"
    }
}
