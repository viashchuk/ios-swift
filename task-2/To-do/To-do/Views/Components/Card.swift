//
//  Card.swift
//  To-do
//
//  Created by Victoria Iashchuk on 03/12/2025.
//

import SwiftUI

struct Card: View {
    @Binding var item: TodoItem
    
    let onToggleStatus: () -> Void
    let onDelete: () -> Void
    let onEdit: () -> Void
    
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
        .contentShape(Rectangle())
        .onTapGesture {
            onToggleStatus()
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: onDelete) {
                  Image(systemName: "trash")
                      .frame(width: 24, height: 24)
              }
            Button(action: onEdit) {
                    Image(systemName: "pencil")
                }
                .tint(.blue)
        }
    }
}

#Preview {
    Card(item: .constant(TodoItem(title: "Test task", isCompleted: false)), onToggleStatus: {}, onDelete: {}, onEdit: {})
}
