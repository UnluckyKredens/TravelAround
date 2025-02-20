//
//  AtractionModel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/16/25.
//

class AtractionModel: Codable, Identifiable {
    var id: Int
    var name: String
    var price: Double //Powinno byc double XD
    var description: String
    var imageUrl: String
    var destination: String
}
