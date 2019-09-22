//
//  ShelvesPickerTableViewCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 03.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class ShelvesPickerTableViewCell: UITableViewCell {

      var shelvesPicker: ShelvesPickerView = {
          let picker = ShelvesPickerView()
          picker.translatesAutoresizingMaskIntoConstraints = false
          return picker
      }()
    static let reuseId = "ShelvesPickerTableViewCell"
    
    
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
             self.backgroundColor = UIColor.clear
            addSubview(shelvesPicker)
            
       
            shelvesPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            shelvesPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            shelvesPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            shelvesPicker.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        
    }
    
    

