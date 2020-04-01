//
//  Requests.swift
//  Supply Helper
//
//  Created by Lambda_School_Loaner_214 on 3/31/20.
//  Copyright © 2020 Empty Bliss. All rights reserved.
//

import Foundation

struct Request: Codable {
    let id: Int
    let createdTimestamp: Date
    let userID: Int
    let itemID: Int
    let fullfilled: Bool?
    let fulfilledUserID: Int?
    let fulfilledTimeStamp: Date?
}
