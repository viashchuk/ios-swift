//
//  RegistrationViewModel.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import Foundation
import Combine

@MainActor
class RegistrationViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    func register() async {
        errorMessage = nil
        
        do {
            let request = RegistrationRequest(name: name, email: email, password: password)
            let response: RegistrationResponse = try await NetworkService.shared.performRequest(
                endpoint: "/register",
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
