//
//  GenerateTravelService.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/25/25.
//

import Foundation

class GenerateTravelService {
    
    func GenerateTravel(model: GenerateTravelModel, userId: Int) async throws -> ReadyTravelModel {
            guard let apiKey = URL(string: "http://localhost:7173/api/GPT/GenerateTravel") else {
                throw NetworkError.badUrl
            }
    
            var request = URLRequest(url: apiKey)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let JsonData = try JSONEncoder().encode(model)
            request.httpBody = JsonData
            
            let (data, res) = try await URLSession.shared.data(for: request)

            guard let httpResponse = res as? HTTPURLResponse else {
                throw NetworkError.badResponse
            }
            
            if httpResponse.statusCode != 200 {
                print(httpResponse.statusCode)
                throw NetworkError.badStatus
            }
            print(res)
            print(try JSONDecoder().decode(ReadyTravelModel.self, from: data))
            return try JSONDecoder().decode(ReadyTravelModel.self, from: data)
        } catch {
            print(error.localizedDescription)
            throw error
        }
            

        
    }
}
