//
//  Locations.swift
//  Supply Helper
//
//  Created by Lambda_School_Loaner_214 on 3/30/20.
//  Copyright © 2020 Empty Bliss. All rights reserved.
//

import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let address: String
    let locationLat: Float
    let locationLon: Float
    var inventory: [LocationInventory] = []
}
