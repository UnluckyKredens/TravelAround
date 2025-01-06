//
//  ReadyTravel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/5/24.
//

import Foundation

class ReadyTravelModel: Identifiable, Codable {
    let travelId: Int
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
