//
//  TableHeader.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 02.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class TableHeader: UITableViewHeaderFooterView {

   static let footerId = "footer"
  
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func confifgureFooter(){
      
              let button = UIButton(type: .system)
              let label = UILabel()
             
              
              button.setTitle("tutu", for: .normal)
              
              label.textColor = UIColor.white
              label.backgroundColor = UIColor.blue
              label.text = "aaa"
        self.addSubview(label)
        self.addSubview(button)
        
       
       
}
}
