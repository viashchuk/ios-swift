//
//  ButtonType.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//
import SwiftUI

enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit: Digit)
    case operation(_ operation: Operation)
    case equal
    case allClear
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .operation(let operation):
            return operation.description
        case .equal:
            return "="
        case .allClear:
            return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .operation, .equal:
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
