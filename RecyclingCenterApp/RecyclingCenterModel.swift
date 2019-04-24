//
//  RecyclingCenterModel.swift
//  RecyclingCenterApp
//
//  Created by Victor Garcia on 4/22/19.
//  Copyright © 2019 Diana Manzano. All rights reserved.
//

//import Foundation
class RecyclingCenterModel{
    var id: String?
    var name : String?
    var ubication: String?
    var type: String?
    var phone: String?
    var managment: String?

    
    
    
    init(id: String?, name : String?, ubication : String?, type : String?, phone : String?, managment: String?) {
        self.id = id
        self.name = name
        self.ubication = ubication
        self.type = type
        self.phone = phone
        self.managment = managment
        
    }
}
