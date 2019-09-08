//
//  ProductAzs.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 31.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import Foundation


struct ProductAzs: Codable {
    var idAzs: Int
    var id: Int
    var name: String
    var typeProduct: TypeProduct
    var data: [Date]?
    var shelves: [Shelves]
    
}
