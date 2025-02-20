//
//  UserService.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/17/25.
//

import Foundation

class UserService {
    
    
    func RegisterUser(user: UserModel) async throws -> String {
        
        guard let url = URL(string: "http://localhost:7173/api/User/register") else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
            
            let (data, _) = try await URLSession.shared.data(for: request)

              guard let res = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines), !res.isEmpty else {
                  throw URLError(.cannotParseResponse)
              }
              
              return res
        }
        catch  {
            throw error
        }
    }
    
    func LoginUser(user: UserModel) async throws -> String {
        guard let url = URL(string: "http://localhost:7173/api/User/login") else {
            throw NetworkError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let body = ["login": user.login, "password": user.password]
            let loginData = try JSONEncoder().encode(body)
            request.httpBody = loginData
            
            print(body)
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            guard let res = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                throw NetworkError.failedToDecodeResponse
            }
            UserDefaults.standard.set(res, forKey: "userId")
            return res
            
        } catch {
            throw error
        }
    }
}
