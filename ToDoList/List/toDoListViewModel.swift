//
//  toDoListViewModel.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import Foundation



class ToDoList {
    
    lazy var toDoArray: [ToDoEnt] = []

    func numThingsToDo() -> Int{
        return toDoArray.count
    }
    
    func getTask(index: Int) -> String{
        return toDoArray[index].title ?? ""
    }
    
    func getDescription(index: Int) -> String {
        return toDoArray[index].description
    }
    
    func getDeadline(index: Int) -> String{
        return toDoArray[index].deadline ?? ""
    }
    
    func isComplete(index: Int) -> Bool{
        return toDoArray[index].complete
    }
    
    func getToDo(index: Int) -> ToDoEnt{
        return toDoArray[index]
    }
    
    func getToDoArray() -> [ToDoEnt]{
        return toDoArray
    }
    
}

