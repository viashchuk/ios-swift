//
//  Operation.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//

enum Operation: CaseIterable, CustomStringConvertible {
    case add
    case subtract
    case multiply
    case divide
    case power
    
    var description: String {
        switch self {
        case .add:      return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide:   return "÷"
        case .power:    return "^"
        }
    }
}

