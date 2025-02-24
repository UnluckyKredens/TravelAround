//
//  FavouriteTravelService.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/22/25.
//

import Foundation
class FavouriteTravelService {
    
    func MakeTravelFavourite(userId: Int, travelId: Int) async throws -> Int {
        do {
            guard let apiKey = URL(string: "http://localhost:7173/api/FavouriteTravel") else {
                throw NetworkError.badUrl
            }
            
            var request = URLRequest(url: apiKey)
            request.httpMethod = "POST"
            request.addValue( "application/json", forHTTPHeaderField: "Content-Type")
            let body = ["userId": userId, "travelId": travelId]
            let travelData = try JSONEncoder().encode(body)
            request.httpBody = travelData
            
            let _ = try await URLSession.shared.data(for: request)
            
            return 1
        }
        catch {
            //            throw error
            return 0
        }
    }
    
    func DeleteFavouriteTravel(userId: Int, travelId: Int) async throws -> Void {
            guard let apiKey = URL(string: "http://localhost:7173/api/FavouriteTravel/delete") else {
                throw NetworkError.badUrl
            }
            
            var request = URLRequest(url: apiKey)
            request.httpMethod = "DELETE"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body = ["userId": userId, "travelId": travelId]
            let travelData = try JSONEncoder().encode(body)
            request.httpBody = travelData
            
            let _ = try await URLSession.shared.data(for: request)
                    
    }
    
    func GetFavouriteTravels(userId: Int) async throws -> [Int] {
        do {
            guard let apiKey = URL(string: "http://localhost:7173/api/FavouriteTravel/userFavourites/\(userId)") else {
                throw NetworkError.badUrl
            }
            
            let (data, res) = try await URLSession.shared.data(from: apiKey)
            
            guard let httpRes = res as? HTTPURLResponse else {
                throw NetworkError.badResponse
            }
            guard (200..<300).contains(httpRes.statusCode) else {
                throw NetworkError.badStatus
            }
            
            let travelList: [ReadyTravelModel] = try JSONDecoder().decode([ReadyTravelModel].self, from: data)
            var travelIds: [Int] = []
            for travel in travelList {
                travelIds.append(travel.travelId)
            }
            
            return travelIds
        }
        catch {
            throw error
        }
    }
}
