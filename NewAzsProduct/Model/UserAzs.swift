//
//  UserAzs.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 31.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import Foundation

class UserAzs: Codable {
    var id: Int
    var nameAzs: Int
    var type: UsetTypeAzs
    var shelves: [Shelves]?
    var login: String
    var password: String
    
    
    init(
        id: Int,
        nameAzs: Int,
        type: UsetTypeAzs,
        shelves: [Shelves]?,
        login: String,
        password: String
       
    ) {
        self.id = id
        self.nameAzs = nameAzs
        self.type = type
        self.shelves = shelves
        self.login = login
        self.password = password
    }
    
}
