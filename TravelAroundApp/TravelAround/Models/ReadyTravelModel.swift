//
//  ReadyTravel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/5/24.
//

import Foundation

class ReadyTravelModel: Identifiable {
    let id: Int
    var imageUrl: String
    var name: String
    var description: String
    var date: String
    var price: Double
    
    init(id: Int, imageUrl: String, name: String, description: String, date: String,  price: Double) {
        self.id = id
        self.imageUrl = imageUrl
        self.name = name
        self.description = description
        self.date = date
        self.price = price
    }
}
