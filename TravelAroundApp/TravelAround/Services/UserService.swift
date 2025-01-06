//
//  UserService.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/29/24.
//

import Foundation


class UserService: Codable {
    var APIUrl =  "http://localhost:5167/api/User/"

        
    func Login(username: String, password: String) async throws -> String {
        guard let url = URL(string: APIUrl + "login") else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["login": username, "password": password]
        
        request.httpBody = try JSONEncoder().encode(body)

        let (data, res) = try await URLSession.shared.data(for: request)

        guard let httpResponse = res as? HTTPURLResponse else {
            
            throw NetworkError.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        guard let token = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines), !token.isEmpty else {
            throw URLError(.cannotParseResponse)
        }
        
        UserDefaults.standard.set(token, forKey: "userId")
        return token;

    }
}
