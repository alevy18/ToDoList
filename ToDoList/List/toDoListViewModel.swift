//
//  toDoListViewModel.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import Foundation

class ToDoList {
    
   private lazy var toDoArray: [ToDo] = []
    
    //adds or edits contents of toDoArray
    func addToDo(title: String, description: String, deadline: String, index: Int?){
        let newTask = ToDo.init()
        newTask.title = title
        newTask.description = description
        newTask.deadline = deadline
        if index == nil{
            toDoArray.append(newTask)
        }else{
            toDoArray[index!] = newTask
        }
    }
    
    func deleteToDo(index: Int){
        toDoArray.remove(at: index)
    }
    
    
    func numThingsToDo() -> Int{
        return toDoArray.count
    }
    
    func getTask(index: Int) -> String{
        return toDoArray[index].title
    }
    
    func getDescription(index: Int) -> String {
        return toDoArray[index].description
    }
    
    func getDeadline(index: Int) -> String{
        return toDoArray[index].deadline 
    }
    
    func isComplete(index: Int) -> Bool{
        return toDoArray[index].complete
    }
    
    func getToDo(index: Int) -> ToDo{
        return toDoArray[index]
    }
    
    
}
