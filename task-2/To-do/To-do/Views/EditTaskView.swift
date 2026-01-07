//
//  EditTaskView.swift
//  To-do
//

import SwiftUI

struct EditTaskView: View {
    @Binding var task: TodoItem
    @Environment(\.dismiss) var dismiss
    
    init(task: Binding<TodoItem>) {
            self._task = task
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().standardAppearance = appearance
        }
    
    var body: some View {
        NavigationStack {
                    ZStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Task title")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextField("Task Title", text: $task.title)
                                .padding()
                                .background(Constants.cardBg)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                    }
                    .navigationTitle("Edit Task")
                    .foregroundColor(.white)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { dismiss() }
                                .foregroundColor(.yellow)
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { dismiss() }
                                .foregroundColor(.white)
                        }
                    }
                }
                .background(Constants.bgColor)
            }
        }


#Preview {
    ContentView()
}
