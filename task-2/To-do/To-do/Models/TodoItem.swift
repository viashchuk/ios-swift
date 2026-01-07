//
//  TodoItem.swift
//  To-do
//
//  Created by Victoria Iashchuk on 03/12/2025.
//
import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
