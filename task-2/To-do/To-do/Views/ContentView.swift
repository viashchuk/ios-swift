//
//  ContentView.swift
//  To-do
//
//  Created by Victoria Iashchuk on 03/12/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [TodoItem] = [
        TodoItem(title: "Task 1", isCompleted: false),
        TodoItem(title: "Task 2", isCompleted: false),
        TodoItem(title: "Task 3", isCompleted: false),
        TodoItem(title: "Task 4", isCompleted: true),
        TodoItem(title: "Task 5", isCompleted: false),
    ]
    @State private var taskToEdit: TodoItem?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                if tasks.isEmpty {
                    ContentUnavailableView("You have no tasks", systemImage: "checklist")
                } else {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("You have \(Text("\(tasks.count) tasks").foregroundColor(.yellow).bold()) today")
                                .bold()
                                .font(.title2)
                                .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top, 40)
                        
                        List {
                            ForEach($tasks) { $task in
                                    Card(
                                        item: $task,
                                        onToggleStatus: {
                                            task.isCompleted.toggle()
                                        },
                                        onDelete: {
                                                if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                                        tasks.remove(at: index)
                                                    }
                                        },
                                        onEdit: {
                                            taskToEdit = task
                                        }
                                    )
                                .listRowInsets(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                                .listRowBackground(Color.clear)
                            }
                            .onDelete { indexSet in
                                tasks.remove(atOffsets: indexSet)
                            }
                        }
                        .padding(.top, 20)
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .background(Constants.bgColor)
        }
        .sheet(item: $taskToEdit) { task in
            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                EditTaskView(task: $tasks[index])
            }
        }
    }
}

#Preview {
    ContentView()
}
