//
//  Button.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//

import SwiftUI

extension CalculatorView {
    struct CalculatorButton: View {
        
        let buttonType: ButtonType
        @EnvironmentObject private var viewModel: ViewModel
        
        var body: some View {
            Button(action: {
                viewModel.action(for: buttonType)
            }, label: {
                buttonLabel
            })
                .buttonStyle(CalculatorButtonStyle(
                    size: getButtonSize(),
                    backgroundColor: buttonType.backgroundColor,
                    isBig: buttonType == .digit(.zero) || buttonType ==  .allClear,
                    buttonType: buttonType
                )
            )
        }
        
        private func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let buttonCount: CGFloat = 4
            let spacingCount = buttonCount + 1
            return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
        }
        
        @ViewBuilder
        private var buttonLabel: some View {
            if buttonType == .operation(.power) {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("x")
                        .font(.system(size: Constants.buttonFontSize, weight: .regular))
                    Text("y")
                        .font(.system(size: Constants.buttonFontSize * 0.75, weight: .regular))
                        .baselineOffset(10)
                }
            } else if buttonType == .smartOperation(.log) {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("log")
                        .font(.system(size: Constants.buttonFontSize, weight: .regular))
                    Text("10")
                        .font(.system(size: Constants.buttonFontSize * 0.75, weight: .regular))
                        .baselineOffset(-10)
                }
            }
            else {
                Text(buttonType.description)
            }
        }
    }
}

struct CalculatorView_CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView.CalculatorButton(buttonType: .digit(.one))
    }
}

