//
//  UserModel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 12/29/24.
//


class UserModel: Codable {
    let userId: String
    var username: String
    var userEmail: String
    var userPassword: String
    var country: String
}
