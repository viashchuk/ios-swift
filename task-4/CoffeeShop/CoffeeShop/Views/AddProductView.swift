//
//  AddProduct.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 01/02/2026.
//

import CoreData
import PhotosUI
import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel = AddProductViewModel()

    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \CategoryEntity.name, ascending: true)
    ])
    var categories: FetchedResults<CategoryEntity>

    @State private var selectedItem: PhotosPickerItem?
    @State private var productImage: UIImage?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Coffee name", text: $viewModel.name)

                    TextField("Price", text: $viewModel.price)
                        .keyboardType(.decimalPad)

                    Picker("Category", selection: $viewModel.selectedCategory) {
                        Text("Select category").tag(nil as CategoryEntity?)
                        ForEach(categories) { category in
                            Text(category.name ?? "").tag(
                                category as CategoryEntity?
                            )
                        }
                    }
                }

                Section("Description") {
                    TextEditor(text: $viewModel.description)
                        .frame(minHeight: 100)
                }

                if viewModel.isSaving {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    Button(action: {
                        Task {
                            let success = await viewModel.saveProduct()
                            if success {
                                dismiss()
                            }
                        }
                    }) {
                        Text("Create")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color(red: 0.1, green: 0.4, blue: 0.3))
                            .cornerRadius(30)
                    }
                    .disabled(!viewModel.isFormValid)
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Create New Product")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
