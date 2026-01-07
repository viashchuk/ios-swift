//
//  Card.swift
//  To-do
//
//  Created by Victoria Iashchuk on 03/12/2025.
//

import SwiftUI

struct Card: View {
    @Binding var item: TodoItem
    
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isCompleted ? .green : .gray)
            
            Text(item.title)
                .font(.body)
                .strikethrough(item.isCompleted)
            
            Spacer()
        }
        .padding()
        .background(Constants.cardBg)
        .cornerRadius(60)
        .shadow(radius: 2)
        .foregroundColor(.white)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: onDelete) {
                  Image(systemName: "trash")
                      .frame(width: 24, height: 24)
              }
        }
    }
}

#Preview {
    Card(item: .constant(TodoItem(title: "Test task", isCompleted: false)), onDelete: {})
}
