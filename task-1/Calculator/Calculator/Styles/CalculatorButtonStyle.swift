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
    var buttonType: ButtonType
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .font(.system(size: Constants.buttonFontSize, weight: .medium))
            .frame(width: size, height: size)
            .frame(maxWidth: isBig ? .infinity : size, alignment: .leading)
            .frame(maxHeight: Constants.buttonMaxHeight)
            .background(backgroundColor)
            .foregroundColor(Color.white)
            .overlay {
                buttonOverlay
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(Capsule())
    }
    
    @ViewBuilder
    private var buttonOverlay: some View {
        let shape = AnyShape(Capsule())
        if UIScreen.main.bounds.width <= 460 {
            let shape = buttonType == .digit(.zero) || buttonType == .allClear || buttonType == .operation(.power)
                ? AnyShape(Capsule())
                : AnyShape(Circle())
        }
        
        shape
            .stroke(
                LinearGradient(
                    colors: [
                        Color(red: 0.45, green: 0.45, blue: 0.48),
                        backgroundColor
//                            Color(red: 0.28, green: 0.28, blue: 0.30)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 2
            )
    }
}

struct CalculatorButtonStyle_Previews: PreviewProvider {
    static let buttonType: ButtonType = .digit(.one)
    
    static var previews: some View {
        Button(buttonType.description) { }
            .buttonStyle(CalculatorButtonStyle(
                size: 80,
                backgroundColor: buttonType.backgroundColor,
                buttonType: buttonType)
            )
    }
}
