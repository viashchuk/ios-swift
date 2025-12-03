//
//  SmartOperation.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//

enum SmartOperation: CaseIterable, CustomStringConvertible {
    case percent
    case log
    
    var description: String {
        switch self {
        case .percent: return "%"
        case .log:     return "log"
        }
    }
}

