//
//  GenerateTravelModel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/25/25.
//

class GenerateTravelModel: Codable {
    var userId: Int
    var price: Float?
    var destination: String
    var from: String
    var members: Int?
    var days: Int?
    
    init(userId: Int, price: Float?, destination: String, from: String, members: Int, days: Int) {
        self.userId = userId
        self.price = price
        self.destination = destination
        self.from = from
        self.members? = members
        self.days? = days
    }
}
