//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//


import Combine

extension CalculatorView {
    final class ViewModel: ObservableObject {
        
        @Published private var calculator = Calculator()
        
        var displayText: String {
            return calculator.displayText
        }
        
        var buttonTypes: [[ButtonType]] {
            [[.allClear, .operation(.divide)],
             [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiply)],
             [.digit(.four), .digit(.five), .digit(.six), .operation(.subtract)],
             [.digit(.one), .digit(.two), .digit(.three), .operation(.add)],
             [.digit(.zero), .equal]]
        }
        
        func action(for buttonType: ButtonType) {
            switch buttonType {
            case .digit(let digit):
                calculator.setDigit(digit)
            case .operation(let operation):
                calculator.setOperation(operation)
            case .equal:
                calculator.evaluate()
            case .allClear:
                calculator.allClear()
            }
        }
        
    }
}
