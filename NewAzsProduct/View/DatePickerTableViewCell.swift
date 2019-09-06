//
//  DatePickerTableViewCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 03.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    
    let datePickerProdukt  = UIDatePicker()
    
    
    static let reuseId = "DatePickerTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        
        
          
              addSubview(datePickerProdukt)
              
    
              datePickerProdukt.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
              datePickerProdukt.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
              datePickerProdukt.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
              datePickerProdukt.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
