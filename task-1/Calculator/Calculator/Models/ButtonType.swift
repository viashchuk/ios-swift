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
    case smartOperation(_ smartOperation: SmartOperation)
    case sign
    case equal
    case allClear
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .operation(let operation):
            return operation.description
        case .smartOperation(let smartOperation):
            return smartOperation.description
        case .sign:
            return "(-)"
        case .equal:
            return "="
        case .allClear:
            return "AC"
            
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .operation(.power), .smartOperation, .sign:
            return Constants.bgDarkGray
        case .operation, .equal:
            return Constants.bgOrange
        case .allClear:
            return Constants.bgLighterGray
        default:
            return Constants.bgLightGray
        }
    }
    
    var foregroundColor: Color {
        return .white
    }
}
