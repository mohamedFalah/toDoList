//
//  DropShadow.swift
//  toDoList
//
//  Created by Mohammed Alshulah on 04/11/2020.
//

import UIKit
import CoreData


extension UIView {
    
    func addDropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 137.0/255.0 , green: 137.0/255.0 , blue: 137.0/255.0, alpha: 1).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:0.0, height: 2.0)
    }
    
    func addCornerRadius (radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    
}


