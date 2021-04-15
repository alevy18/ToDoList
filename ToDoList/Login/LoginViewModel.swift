//
//  LoginViewModel.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/6/21.
//

import Foundation

class LoginViewModel{
    
    lazy var loginStuff = login.init()
    
    
    func editPassword(changeTo: String){
        loginStuff.password = changeTo
    }
    
    func editUsername(changeTo: String){
        loginStuff.username = changeTo
    }
    
    func isGreaterThanLimit(string: String) -> Bool{
        if string.count >= 15{
            return false
        }else{
            return true
        }
    }
    

}





