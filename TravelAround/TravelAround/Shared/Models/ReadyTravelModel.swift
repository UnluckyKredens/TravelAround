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
    var price: Double //POWINNO BYC DOUBLE XDD
    var from: String
    var destination: String
    var members: Double
    var likes: Int
    var atractions: [AtractionModel]?
    
    init(travelId: Int, imageUrl: String, name: String, description: String, price: Double, from: String, destination: String, members: Double, likes: Int) {
        self.travelId = travelId
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
        self.price = price
        self.from = from
        self.destination = destination
        self.members = members
        self.likes = likes
    }
}
