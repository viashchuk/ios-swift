//
//  Calculator.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//

import Foundation

struct Calculator {
    var displayText: String = "0"
    private var isTyping: Bool = false
    private var operation: Operation? = nil
    private var smartOperation: SmartOperation? = nil
    private var number: Double?
    
    mutating func setOperation(_ op: Operation) {
        let textToParse = smartOperation == .percent ? String(displayText.dropLast()) : displayText
        
        if let value = Double(textToParse) {
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
        smartOperation = nil
    }
    
    mutating func setDigit(_ digit: Digit) {
        let value = digit.description
        
        if smartOperation == .log {
            displayText = displayText.dropLast() + value + ")"
        }
        else {
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
    }
    
    mutating func evaluate() {
        if let smartOperation = smartOperation {
            let result = smartOperations()
            displayText = format(result)
        } else {
            guard
                let op = operation,
                let first = number,
                let second = Double(displayText)
            else { return }
            
            let result = operations(op, first, second)
            displayText = format(result)
        }
    }
    
    mutating func setLogarithm() {
        smartOperation = .log
        
        if displayText == "0" {
            displayText = "log()"
        } else {
            displayText = "log(" + displayText + ")"
        }
        
        isTyping = false
    }
    
    mutating func toggleSign() {
        guard var value = Double(displayText) else { return }
        value = -value
        displayText = format(value)
    }
    
    mutating func setPercent() {
        smartOperation = .percent
        displayText += "%"
        isTyping = false
    }
    
    mutating func smartOperations() -> Double {
        switch smartOperation {
        case .log:
            let value = Double(displayText.filter { $0.isNumber || $0 == "." }) ?? 0
            return log10(value)
        case .percent:
            guard
                let op = operation,
                let firstNumber = number,
                let parseSecondNumber = displayText.last == "%" ? Double(displayText.dropLast()) : Double(displayText)
            else { return 0 }
            
            let second: Double
            let first: Double
            
            if displayText.last == "%" {
                second = parseSecondNumber * firstNumber / 100
                first = firstNumber
            } else {
                first = firstNumber * parseSecondNumber / 100
                second = parseSecondNumber
            }
            
            let result = operations(op, first, second)
            
            return result
        case .none:
            break
        }
        return 0
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
        case .power:
            return pow(firstNumber, secondNumber)
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
