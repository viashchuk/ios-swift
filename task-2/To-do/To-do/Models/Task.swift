//
//  Task.swift
//  To-do
//
//  Created by Victoria Iashchuk on 03/12/2025.
//
import Foundation

struct Task: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted: Bool = false
}
