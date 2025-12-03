//
//  Card.swift
//  To-do
//
//  Created by Victoria Iashchuk on 03/12/2025.
//

import SwiftUI

struct Card: View {
    let task: Task
    
    var body: some View {
        HStack {
        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            .foregroundColor(task.isCompleted ? .green : .gray)
                    
        Text(task.title)
            .font(.body)
            .strikethrough(task.isCompleted)
                    
        Spacer()
    }
    .padding()
    .background(Color.white)
    .cornerRadius(10)
    .shadow(radius: 2)
    }
}

#Preview {
    Card(task: Task(title: "Test task", isCompleted: false))
}
