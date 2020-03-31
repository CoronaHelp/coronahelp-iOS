//
//  users.swift
//  Supply Helper
//
//  Created by Lambda_School_Loaner_214 on 3/30/20.
//  Copyright © 2020 Empty Bliss. All rights reserved.
//

import Foundation

struct user: Codable {
    let id: Int
    let lastName: String
    let firstName: String
    let emailAddress: String
    let userName: String
    let locationLat: Float
    let locationLon: Float
    let zip: Int
    let prefRadius: Int
}
