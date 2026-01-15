//
//  LoginViewModel.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    func login() async {
        errorMessage = nil
        
        do {
            let request = LoginRequest(email: email, password: password)
            let response: LoginResponse = try await NetworkService.shared.performRequest(
                endpoint: "/login",
                body: request
            )
            saveToken(response.token)
            self.isLoggedIn = true
        } catch {
            handleError(error)
        }
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

