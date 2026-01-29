//
//  NetworkService.swift
//  CoffeeShop
//
//  Created by Victoria Iashchuk on 29/01/2026.
//


import Foundation

enum RequestError: Error {
    case invalidResponse
    case wrongCredentials
    case serverError
    case wrongStatus
    case unauthorized
    
    var description: String {
        switch self {
        case .invalidResponse:
            return "Invalid server response"
        case .wrongCredentials:
            return "Wrong Email or Password"
        case .serverError:
            return "Server error"
        case .wrongStatus:
            return "wrongStatus"
        case .unauthorized:
            return "unauthorized"
        }
    }
}

class NetworkService {
    static let shared = NetworkService()
    
    func performRequest<T: Decodable>(
            endpoint: String,
            method: String = "GET",
            body: [String: Any]? = nil,
            queryParameters: [String: String]? = nil,
            requiresAuth: Bool = false
        ) async throws -> T {
            var urlString = Constants.baseURL + endpoint
            print(urlString)
            
            if let queryParameters = queryParameters, !queryParameters.isEmpty {
                var components = URLComponents(string: urlString)
                components?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
                urlString = components?.url?.absoluteString ?? urlString
            }
            
            guard let url = URL(string: urlString) else { throw RequestError.serverError }
                var request = URLRequest(url: url)
                request.httpMethod = method
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                if let body = body {
                    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
                }
            
            if requiresAuth {
                guard let token = UserDefaults.standard.string(forKey: "userToken") else {
                    throw RequestError.unauthorized
                }
                print(token)
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RequestError.invalidResponse
            }
            
            print(httpResponse.statusCode)
            guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
                throw httpResponse.statusCode == 401 ?
                RequestError.wrongCredentials :
                RequestError.wrongStatus
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                print("Decoding error: \(error)")
                throw error
            }
        }
}
