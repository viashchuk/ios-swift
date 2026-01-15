//
//  NetworkService.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 16/01/2026.
//

import Foundation

enum RequestError: Error {
    case invalidResponse
    case wrongCredentials
    case serverError
    
    var description: String {
        switch self {
        case .invalidResponse:
            return "Invalid server response"
        case .wrongCredentials:
            return "Wrong Email or Password"
        case .serverError:
            return "Server error"
        }
    }
}

class NetworkService {
    static let shared = NetworkService()
    
    func performRequest<T: Decodable, B: Encodable>(
        endpoint: String,
        body: B,
        method: String = "POST"
    ) async throws -> T {
        guard let url = URL(string: Constants.baseURL + endpoint) else {
            throw RequestError.serverError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw httpResponse.statusCode == 401 ?
            RequestError.wrongCredentials :
            RequestError.serverError
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
