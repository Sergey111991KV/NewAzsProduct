//
//  ShelvesLabelTableViewCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 03.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class ShelvesLabelTableViewCell: UITableViewCell {

     static let idCellForClothe = 3
    
     var labelShelves: UILabel = {
               var label = UILabel()
               label.text = "aaa"
               label.translatesAutoresizingMaskIntoConstraints = false
               return label
           }()
   
    static let reuseId = "ShelvesLabelTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
         addSubview(labelShelves)
                labelShelves.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
                       labelShelves.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
                       labelShelves.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
                       labelShelves.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
