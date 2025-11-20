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
            [[.allClear],
             [.seven, .eight, .nine],
             [.four, .five, .six],
             [.one, .two, .three, .add],
             [.zero, .equal]]
        }
        
        func action(for buttonType: ButtonType) {
            switch buttonType {
            case .zero:
                calculator.setDigit(.zero)
            case .one:
                calculator.setDigit(.one)
            case .two:
                calculator.setDigit(.two)
            case .three:
                calculator.setDigit(.three)
            case .four:
                calculator.setDigit(.four)
            case .five:
                calculator.setDigit(.five)
            case .six:
                calculator.setDigit(.six)
            case .seven:
                calculator.setDigit(.seven)
            case .eight:
                calculator.setDigit(.eight)
            case .nine:
                calculator.setDigit(.nine)
            case .add:
                calculator.setOperation(.add)
            case .equal:
                calculator.evaluate()
            case .allClear:
                calculator.allClear()
            }
        }
        
    }
}
