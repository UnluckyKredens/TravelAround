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
    var price: Float
    var from: String
    var destination: String
    var days: Int
    var members: Int
    var likes: Int
    var atractions: [AtractionModel]?
    
    init(travelId: Int, imageUrl: String, days: Int, name: String, description: String, price: Float, from: String, destination: String, members: Int, likes: Int) {
        self.travelId = travelId
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
        self.price = price
        self.from = from
        self.destination = destination
        self.members = members
        self.likes = likes
        self.days = days
    }
}
