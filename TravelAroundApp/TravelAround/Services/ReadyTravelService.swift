//
//  ReadyTravelService.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/27/24.
//

import Foundation


class ReadyTravelService: Codable {
    
    var APIUrl =  "http://localhost:5167/api/ReadyTravels"
    
    func GetAllTravels() async throws -> [ReadyTravelModel] {
        guard let url = URL(string: APIUrl) else {
                   fatalError("Niepoprawny URL API")
               }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 200 else {
            throw NetworkError.invalidRequest
        }
        
        let travels = try JSONDecoder().decode([ReadyTravelModel].self, from: data)
        return travels
    }
}
