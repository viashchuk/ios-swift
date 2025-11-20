//
//  CalculatorView.swift
//  Calculator
//
//  Created by Victoria Iashchuk on 20/11/2025.
//

import SwiftUI

struct CalculatorView: View {
    
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        VStack {
                Spacer()
                displayText
                buttons
        }
        .padding(Constants.padding)
        .background(Color.black)
    }
}

#Preview {
    CalculatorView()
        .environmentObject(CalculatorView.ViewModel())
}


extension CalculatorView {
    
    private var displayText: some View {
        Text(viewModel.displayText)
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 88, weight: .light))
            .lineLimit(1)
            .minimumScaleFactor(0.2)
    }
    
    private var buttons: some View {
        VStack(spacing: Constants.padding) {
            ForEach(viewModel.buttonTypes, id: \.self) { row in
                HStack(spacing: Constants.padding) {
                    ForEach(row, id: \.self) { buttonType in
                        CalculatorButton(
                            buttonType: buttonType
                        )
                    }
                }
            }
        }
    }
}
