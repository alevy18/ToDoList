//
//  ToDo.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import Foundation

#warning("is this class needed?")
class ToDo {

    var title: String = ""
    var description: String = ""
    var complete: Bool = false
    var deadline: String = ""
    
    init(title: String = "", description: String = "", complete: Bool = false, deadline: String = "") {
        self.title = title
        self.description = description
        self.complete = complete
        self.deadline = deadline
    }
}
