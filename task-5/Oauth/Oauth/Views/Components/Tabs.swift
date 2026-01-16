//
//  Tabs.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import SwiftUI

struct Tabs: View {
    let tabs: [String]
    @Binding var selectedTabIndex: Int
    
    @Namespace private var namespace
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs.indices, id: \.self) { i in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        selectedTabIndex = i
                    }
                } label: {
                    Text(tabs[i])
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(i == selectedTabIndex ? .black : .black.opacity(0.45))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            if selectedTabIndex == i {
                                RoundedRectangle(cornerRadius: 60)
                                    .fill(.white)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                                    .matchedGeometryEffect(id: "activeTab", in: namespace)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(6)
        .frame(height: 64)
        .background(Color.black.opacity(0.06))
        .cornerRadius(60)
        .padding(.top, 6)
    }
}

#Preview {
    Tabs(
        tabs: WelcomeView.Tab.allCases.map { $0.rawValue },
        selectedTabIndex: .constant(1)
    )
}
