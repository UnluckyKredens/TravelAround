//
//  UserModel.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/17/25.
//

import Foundation

class UserModel: Codable, Identifiable, ObservableObject {
    var id: String
    var username: String
    var login: String
    var password: String
    var email: String
    var address: String
    
    init(id: String, username: String, login: String, password: String, email: String, address: String) {
        self.id = id
        self.username = username
        self.login = login
        self.password = password
        self.email = email
        self.address = address
    }
}
