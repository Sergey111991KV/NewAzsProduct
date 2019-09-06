//
//  IdTableViewCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 04.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class IdTableViewCell: UITableViewCell {
    
     static let reuseId = "IdTableViewCell"
        
        let idTextField: IdTextField = {
            let textField = IdTextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            return textField
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .default, reuseIdentifier: reuseIdentifier)
          
             addSubview(idTextField)
            
            idTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
             idTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
             idTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
             idTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
            
           
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


