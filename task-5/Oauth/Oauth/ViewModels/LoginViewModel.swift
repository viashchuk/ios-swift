//
//  LoginViewModel.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 15/01/2026.
//

import Foundation
import Combine
import GoogleSignIn
import AuthenticationServices


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
    
    func loginWithGitHub() async {
        let clientID = Secrets.githubClientID
        let scheme = "github-auth"
        
        let authURL = URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=user")!
        
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme) { callbackURL, error in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            guard let callbackURL = callbackURL,
                  let components = URLComponents(string: callbackURL.absoluteString),
                  let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
                return
            }
            
            Task {
                await self.sendCodeToBackend(code)
            }
        }
        
        session.presentationContextProvider = self
        session.start()
    }
    
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
            self.currentUser = response.user
            
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
            self.currentUser = response.user
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
    
    private func sendCodeToBackend(_ code: String) async {
        self.errorMessage = nil
        
        do {
            let authBody = GitHubAuthRequest(code: code)
            
            let response: LoginResponse = try await NetworkService.shared.performRequest(
                endpoint: "/oauth/github",
                body: authBody
            )
            saveToken(response.token)
            self.currentUser = response.user
            
        } catch {
            handleError(error)
        }
    }
}

extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first { $0.isKeyWindow } ?? ASPresentationAnchor()
    }
}
