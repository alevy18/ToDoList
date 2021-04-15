//
//  CoreData.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/14/21.
//

import Foundation
import UIKit
import CoreData


class CD{
    
    static let shared = CD.init()
    private init(){}
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func loadSavedDataToTable(handler: (([ToDoEnt]?, Error?)->())?){
        let fetchRequest = NSFetchRequest<ToDoEnt>.init(entityName: "ToDoEnt")
        do{
            let fetchedData = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            handler?(fetchedData, nil)
        }catch{
            print(error)
            handler?(nil, error)
        }
    }
    
    func saveData(title: String, description: String, deadline: String, complete: Bool){
        let TD = ToDoEnt.init(context: appDelegate.persistentContainer.viewContext)
        TD.title = title
        TD.descrip = description
        TD.deadline = deadline
        TD.complete = complete
        appDelegate.saveContext()
    }
    
}
