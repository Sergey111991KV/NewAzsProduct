//
//  ProductCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 10.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    static let idCellForClothe = true
      
    static let reuseId = "ProductCell"
  
    
    var labelProduct: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var labelDateProduct: UILabel = {
           var label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
         self.backgroundColor = UIColor.clear
        addSubview(labelProduct)
        addSubview(labelDateProduct)
        labelProduct.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        labelProduct.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        labelProduct.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
          labelProduct.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3).isActive = true
        
      
        labelDateProduct.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        labelDateProduct.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        labelDateProduct.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        labelDateProduct.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        
          
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      

}
