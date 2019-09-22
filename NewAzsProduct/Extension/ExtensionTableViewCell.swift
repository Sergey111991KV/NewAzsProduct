//
//  ExtensionTableViewCell.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 15.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

extension UITableViewCell {

    func backgroundColorSelected(bool: Bool){
        if bool{
            self.backgroundColor = UIColor.gray
        }else{
            self.backgroundColor = UIColor.clear
        }
    }
}
    
