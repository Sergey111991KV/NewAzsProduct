//
//  DateLabelTableViewCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 03.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class DateLabelTableViewCell: UITableViewCell {

    static let reuseId = "DateLabelTableViewCell"

     static let idCellForClothe = 2
    
        var labelDate: UILabel = {
            var label = UILabel()
            label.text = "aaa"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .default, reuseIdentifier: reuseIdentifier)
            addSubview(labelDate)
             labelDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
                    labelDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
                    labelDate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
                    labelDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

    
    

