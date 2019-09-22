//
//  UserAzs.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 31.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import Foundation

class UserShop: Codable {
    var id: Int
    var nameShopId: Int
    var type: UserTypeShop
    var shelves: [Shelves]?
    var login: String
    var password: String
    
    
    init(
        id: Int,
        nameAzs: Int,
        type: UserTypeShop,
        shelves: [Shelves]?,
        login: String,
        password: String
       
    ) {
        self.id = id
        self.nameShopId = nameAzs
        self.type = type
        self.shelves = shelves
        self.login = login
        self.password = password
    }
    
}
