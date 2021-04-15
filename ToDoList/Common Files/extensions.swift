//
//  viewMethods.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/7/21.
//

import Foundation

import UIKit

extension UIView {
    func changeBorderColor(borderWidth: Int, color: UIColor){
        layer.borderWidth = CGFloat(borderWidth)
        layer.borderColor = color.cgColor
    }
    
    func removeBorder(){
        layer.borderWidth = 0
        layer.borderColor = nil
    }
    
    func isGreaterThanLimit(string: String) -> Bool{
        if string.count >= 15{
            return false
        }else{
            return true
        }
    }
    
    func font(){
        
    }
    
}
