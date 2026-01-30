//
//  HomeViewModel.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 30/01/2026.
//


import Combine
import Foundation

struct ProductsResponse: Codable {
    let success: Bool
    let products: [Product]
    let error: String?
}

struct CategoriesResponse: Codable {
    let success: Bool
    let categories: [Category]
    let error: String?
}

@MainActor
class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var categories: [Category] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchProducts() async {
        isLoading = true
        errorMessage = nil

        do {
            let response: ProductsResponse = try await NetworkService.shared
                .performRequest(
                    endpoint: "/products",
                    method: "GET",
                    requiresAuth: false
                )
            self.products = response.products
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchCategories() async {
        isLoading = true
        errorMessage = nil

        do {
            let response: CategoriesResponse = try await NetworkService.shared
                .performRequest(
                    endpoint: "/categories",
                    method: "GET",
                    requiresAuth: false
                )
            self.categories = response.categories
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    private func handleError(_ error: Error) {
        if let reqError = error as? RequestError {
            errorMessage = reqError.description
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
