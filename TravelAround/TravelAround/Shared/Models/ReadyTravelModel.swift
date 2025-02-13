//
//  ReadyTravel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 1/28/25.
//
import Foundation

class ReadyTravelModel: Codable, Identifiable {
    var travelId: Int
    var imageUrl: String
    var name: String
    var description: String
    var price: Double
    
    init(travelId: Int, imageUrl: String, name: String, description: String, price: Double) {
        self.travelId = travelId
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
        self.price = price
    }
}
