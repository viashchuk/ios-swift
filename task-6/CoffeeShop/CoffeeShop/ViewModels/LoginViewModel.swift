//
//  LoginViewModel.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//


import Foundation
import Combine


@MainActor
class LoginViewModel: NSObject, ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    @Published var currentUser: User? {
        didSet {
            isLoggedIn = (currentUser != nil)
        }
    }
    
    func login() async {
        errorMessage = nil
        
        do {
            let request: [String: Any] = [
                "email": email,
                "password": password
            ]
            let response: LoginResponse = try await NetworkService.shared.performRequest(
                endpoint: "/login",
                method: "POST",
                body: request,
                requiresAuth: false
            )
            saveToken(response.token)
            self.currentUser = response.user
        } catch {
            handleError(error)
        }
    }
    
    func logout() {
        self.currentUser = nil
        self.isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "userToken")
    }
    
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "userToken")
    }
    
    private func handleError(_ error: Error) {
        if let reqError = error as? RequestError {
            errorMessage = reqError.description
        } else {
            errorMessage = error.localizedDescription
        }
    }
}
