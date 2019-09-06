//
//  TypePickerTableViewCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 03.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class TypePickerTableViewCell: UITableViewCell {
    
    var typePicker: TypePickerView = {
        let picker = TypePickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
 static let reuseId = "TypePickerTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(typePicker)
        
       
        typePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        typePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        typePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        typePicker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
