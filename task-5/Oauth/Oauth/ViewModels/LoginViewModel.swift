//
//  LoginViewModel.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import Foundation
import Combine
import GoogleSignIn

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    func loginWithGoogle() async {
            self.errorMessage = nil
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                self.errorMessage = "Error window"
                return
            }
            
            do {
                let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                
                let user = result.user
                let email = user.profile?.email ?? ""
                let name = user.profile?.name ?? ""
                let idToken = user.idToken?.tokenString ?? ""
                
                let authBody = GoogleAuthRequest(email: email, name: name, token: idToken)
                
                let response: LoginResponse = try await NetworkService.shared.performRequest(
                    endpoint: "/oauth/google",
                    body: authBody
                )
                
                saveToken(response.token)
                self.isLoggedIn = true
                
            } catch {
                handleError(error)
            }
        }
    
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

