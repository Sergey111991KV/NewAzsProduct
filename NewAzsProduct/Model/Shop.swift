//
//  Azs.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 31.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import Foundation

class Shop: Codable {
  
    var id: Int
    var product: [ProductSho]
    var shelves: [Shelves]
    
    init(
      
        id: Int,
        product: [ProductSho],
        shelves: [Shelves]
    ) {
        
        self.id = id
        self.product = product
        self.shelves = shelves
    }
}
