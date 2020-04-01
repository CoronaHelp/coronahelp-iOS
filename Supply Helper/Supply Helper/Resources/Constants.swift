//
//  Constants.swift
//  Supply Helper
//
//  Created by Lambda_School_Loaner_214 on 3/31/20.
//  Copyright © 2020 Empty Bliss. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum FetchError: String, Error {
    case badData = "There was a data error. Please try again." // TODO Fix error messages
    case badResponse = "There was a bad response. Please try again."
    case badEncode = "There was a problem encoding. Please try again."
    case otherError = "Something went wrong. Please try again."
    case noUser = "Please log in."
}
