//
//  Calculator.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//

struct Calculator {
    var displayText: String = "0"
    private var isTyping: Bool = false
    private var operation: Operation? = nil
    private var number: Double?
    
    mutating func setOperation(_ op: Operation) {
        if let value = Double(displayText) {
            number = value
            operation = op
            isTyping = false
        }
    }
    
    mutating func allClear() {
        displayText = "0"
        isTyping = false
        operation = nil
        number = nil
    }
    
    mutating func setDigit(_ digit: Digit) {
        let value = digit.description
        if isTyping {
            if displayText == "0" {
                displayText = value
            } else {
                displayText += value
            }
        } else {
            displayText = value
            isTyping = true
        }
    }
    
    mutating func evaluate() {
        guard
            let op = operation,
            let first = number,
            let second = Double(displayText)
        else { return }
        
        let result = operations(op, first, second)
        displayText = format(result)
    }
    
    private func operations(_ op: Operation, _ firstNumber: Double, _ secondNumber: Double) -> Double {
        switch op {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    private func format(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
}
