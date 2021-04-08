//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import UIKit

protocol SendCompletedInfo {
    func changeCompleteStatus(task: String)
}

class ToDoTableViewCell: UITableViewCell {
    
    var delegate: SendCompletedInfo?

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
 
    @IBOutlet weak var deadlineTxtField: UITextField!
    
    @IBOutlet weak var isCOmpletedSwitch: SmartSegmentControl!
   
    
    func disableScreenElements(){
        descriptionTextView.isEditable = false
        deadlineTxtField.isUserInteractionEnabled = false
    }
    
    
    @IBAction func didFinishTask(_ sender: SmartSegmentControl) {
        var model = sender.model as? ToDo
        if sender.selectedSegmentIndex == 0{
            model?.complete = false
        }else{
            model?.complete = true
        }
        delegate?.changeCompleteStatus(task: (model?.title)!)
    }
    
}
