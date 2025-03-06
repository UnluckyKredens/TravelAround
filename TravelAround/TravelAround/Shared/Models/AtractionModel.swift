//
//  AtractionModel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/16/25.
//

class AtractionModel: Codable, Identifiable {
    var id: Int
    var name: String
    var price: Float //Powinno byc Float XD
    var description: String
    var imageUrl: String?
    var destination: String
}
