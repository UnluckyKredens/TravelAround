//
//  TravelService.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/15/25.
//

import Foundation

class TravelService {
        
    
    func DownloadTopTravels() async throws -> [ReadyTravelModel] {
        do {
            guard let apiKey = URL(string: "http://127.0.0.1:7173/api/Travel/top") else {
                throw URLError(.badURL)
            }
            let (data, res) = try await URLSession.shared.data(from: apiKey)
            
            guard let httpRes = res as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            guard (200..<300).contains(httpRes.statusCode) else {
                throw NetworkError.badStatus
            }
            let travels = try JSONDecoder().decode([ReadyTravelModel].self, from: data)
            return travels
        } catch {
            print(String(describing: error))
            throw error
        }
    }
    
    func DownloadMyTravels() async throws -> [ReadyTravelModel] {
        do {
            guard let apiKey = URL(string: "http://127.0.0.1:7173/api/Travel/top") else {
                throw URLError(.badURL)
            }
            let (data, res) = try await URLSession.shared.data(from: apiKey)
            
            guard let httpRes = res as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            guard (200..<300).contains(httpRes.statusCode) else {
                throw NetworkError.badStatus
            }
            let travels = try JSONDecoder().decode([ReadyTravelModel].self, from: data)
            return travels
        } catch {
            print(String(describing: error))
            throw error
        }
    }
}
