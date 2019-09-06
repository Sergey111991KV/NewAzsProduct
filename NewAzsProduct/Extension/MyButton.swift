//
//  MyButton.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 02.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

extension UIButton {
    func myConfigure(){
        if self.titleLabel?.text == "Открыть"{
            self.setTitle("Закрыть", for: .normal)
        }else{
            self.setTitle("Открыть", for: .normal)
        }
    }
}
