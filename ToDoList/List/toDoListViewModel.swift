//
//  toDoListViewModel.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import Foundation



class ToDoList {
    
    
    var savedArr: [String] = []
    
    lazy var toDoArray: [ToDoEnt] = []
    
    //adds or edits contents of toDoArray
    func addToDo(title: String, description: String, deadline: String, index: Int?, completionHandler: (()->())?){
        
        if index == nil{
            //toDoArray.append(newTask)
            CD.shared.saveData(title: title, description: description, deadline: deadline, complete: false)
        }else{
            //toDoArray[index!] = newTask
        }
    }
    
    
    
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
    
    deinit {
        print("hello")
    }
    
}

