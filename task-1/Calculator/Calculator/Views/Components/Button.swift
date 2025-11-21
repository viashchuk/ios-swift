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
            Button(buttonType.description) {
                viewModel.action(for: buttonType)
            }
                .buttonStyle(CalculatorButtonStyle(
                    size: 84,
                    backgroundColor: buttonType.backgroundColor,
                    isBig: buttonType == .digit(.zero) || buttonType ==  .allClear
                )
            )
        }
        
        private func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let buttonCount: CGFloat = 4
            let spacingCount = buttonCount + 1
            return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
        }
    }
}

struct CalculatorView_CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView.CalculatorButton(buttonType: .digit(.one))
    }
}
