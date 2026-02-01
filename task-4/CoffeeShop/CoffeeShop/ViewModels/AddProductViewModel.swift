//
//  AddProductViewModel.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 01/02/2026.
//

import Foundation
import SwiftUI
import CoreData
import Combine


struct ProductResponse: Codable {
    let success: Bool
    let product: ProductDTO
    let error: String?
}

@MainActor
class AddProductViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var description: String = ""
    @Published var selectedCategory: CategoryEntity?
    
    @Published var isSaving = false
    @Published var errorMessage: String?
    @Published var showAlert = false
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    var isFormValid: Bool {
        !name.isEmpty && !price.isEmpty && selectedCategory != nil && !isSaving
    }

    func saveProduct() async -> Bool {
        print("START SAVE REQUEST")
        
        guard isFormValid else { return false }
        
        isSaving = true
        
        let body: [String: Any] = [
            "name": name,
            "price": Double(price.replacingOccurrences(of: ",", with: ".")) ?? 0.0,
            "categoryId": Int(selectedCategory?.id ?? 0),
            "details": description
        ]
        
        do {
            let newProductDTO: ProductResponse = try await NetworkService.shared.performRequest(
                endpoint: "/products",
                method: "POST",
                body: body,
                requiresAuth: true
            )
            
            saveToCoreData(dto: newProductDTO.product)
            
            isSaving = false
            return true
        } catch {
            isSaving = false
            errorMessage = error.localizedDescription
            showAlert = true
            return false
        }
    }
    
    private func saveToCoreData(dto: ProductDTO) {
        let product = ProductEntity(context: context)
        product.id = Int64(dto.id)
        product.name = dto.name
        product.price = dto.price
        product.imageUrl = dto.imageUrl
        product.category = selectedCategory
        
        try? context.save()
    }
}
