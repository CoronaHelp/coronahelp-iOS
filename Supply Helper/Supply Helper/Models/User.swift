//
//  users.swift
//  Supply Helper
//
//  Created by Lambda_School_Loaner_214 on 3/30/20.
//  Copyright © 2020 Empty Bliss. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int?
    let lastName: String?
    let firstName: String?
    let emailAddress: String
    let username: String?
    let locationLat: Float?
    let locationLon: Float?
    let address: String?
    let prefRadius: Int?
    let password: String?
}

struct LoginResult: Codable {
    var user: User?
    var token: String?
    var message: String
}

struct SignInInfo: Codable {
    var email: String
    var password: String
}
