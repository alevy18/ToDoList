//
//  datePickerModel.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/6/21.
//

import Foundation

struct datePicker{
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var days = Array(1...31)
    var years = Array(1950...2050)
    
    var month: String = ""
    var day: String = ""
    var year: String = ""
}
