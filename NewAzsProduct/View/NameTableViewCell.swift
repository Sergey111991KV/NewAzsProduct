//
//  NameTableViewCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 03.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

  static let reuseId = "NameTableViewCell"
    
    let nameTextField: NameTextField = {
        let textField = NameTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
         addSubview(nameTextField)
        
        nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
         nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
         nameTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
         nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
