//
//  Shelves.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 31.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import Foundation


enum Shelves: Int, Codable{
    
    case first = 1
    case second = 2
    case third = 3
    case four = 4
    case fife = 5
    case six = 6
    case fifteen = 15
    case sixteen = 16
    
    static let all = [Shelves.first, Shelves.second, Shelves.third, Shelves.four, Shelves.fife, Shelves.six, Shelves.fifteen, Shelves.sixteen]

}
