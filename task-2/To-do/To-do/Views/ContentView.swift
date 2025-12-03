//
//  ContentView.swift
//  To-do
//
//  Created by Victoria Iashchuk on 03/12/2025.
//

import SwiftUI

struct ContentView: View {
    let tasks: [Task] = [
        Task(title: "Task 1", isCompleted: false),
        Task(title: "Task 2", isCompleted: false),
        Task(title: "Task 3", isCompleted: false),
        Task(title: "Task 4", isCompleted: true),
        Task(title: "Task 5", isCompleted: false),
    ]
    var body: some View {
        NavigationStack {
                    ZStack {
                        Color.gray.opacity(0.1).ignoresSafeArea()
                        
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(tasks) { task in
                                    Card(task: task)
                                }
                            }
                            .padding()
                        }
                    }
                    .navigationTitle("All Tasks")
                }
    }
}

#Preview {
    ContentView()
}
