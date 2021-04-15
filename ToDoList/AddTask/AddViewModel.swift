//
//  AddViewModel.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/9/21.
//

import Foundation

class AddViewModel {
    
    var buttonTitle = "Add"
    
    var toDoEntModel: ToDoEnt?
    
    func getModelDescrip() -> String{
        return toDoEntModel?.descrip ?? ""
    }
    
    func getModelTitle() -> String{
        return toDoEntModel?.title ?? ""
    }
    
    func getModelDeadline() -> String{
        return toDoEntModel?.deadline ?? ""
    }
    
}
