//
//  CalculatorButtonStyle.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//

import SwiftUI

struct CalculatorButtonStyle: ButtonStyle {
    
    var size: CGFloat
    var backgroundColor: Color
    var isBig: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .font(.system(size: 32, weight: .medium))
            .frame(width: size, height: size)
            .frame(maxWidth: isBig ? .infinity : size, alignment: .leading)
            .background(backgroundColor)
            .foregroundColor(Color.white)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(Capsule())
    }
}

struct CalculatorButtonStyle_Previews: PreviewProvider {
    static let buttonType: ButtonType = .digit(.one)
    
    static var previews: some View {
        Button(buttonType.description) { }
            .buttonStyle(CalculatorButtonStyle(
                size: 80,
                backgroundColor: buttonType.backgroundColor)
            )
    }
}
