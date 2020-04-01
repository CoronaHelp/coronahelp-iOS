//
//  ModelController.swift
//  Supply Helper
//
//  Created by Lambda_School_Loaner_214 on 4/1/20.
//  Copyright © 2020 Empty Bliss. All rights reserved.
//

import Foundation

class ModelController {
    let networkController: ModelNetworkControllerProtocol = WebRESTAPINetworkController()
    var zipCode: String? {
        didSet{
            
        }
    }
    var requests: [Request] = [] {
        didSet{
                
        }
    }
    var locations: [Location] = [] {
        didSet{
            
        }
    }
    
    init () {
        
    }
}
