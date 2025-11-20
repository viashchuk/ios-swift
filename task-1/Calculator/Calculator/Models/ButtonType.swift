//
//  ButtonType.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//
import SwiftUI

enum ButtonType {
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
    case add
    case equal
    case allClear
    
    var description: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .add:
            return "+"
        case .equal:
            return "="
        case .allClear:
            return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .add, .equal:
            return Color.orange
        case .allClear:
            return Color(.lightGray)
        default:
            return .secondary
        }
    }
    
    var foregroundColor: Color {
        return .white
    }
}
