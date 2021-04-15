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
    
    
    //called when completed segmented control is switched
    @IBAction func didFinishTask(_ sender: SmartSegmentControl) {
        let model = sender.model as? ToDoEnt
        if sender.selectedSegmentIndex == 0{
            model?.complete = false
        }else{
            model?.complete = true
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        delegate?.changeCompleteStatus(task: (model?.title)!)
    
    }
    
    
    
    func setCell(toDoObj: ToDoEnt){
        titleLbl.text = toDoObj.title
        descriptionTextView.text = toDoObj.descrip
        deadlineTxtField.text = toDoObj.deadline
        isCOmpletedSwitch.model = toDoObj
        
        
        //darkens cell if marked complete
        if toDoObj.complete == true{
            isCOmpletedSwitch.selectedSegmentIndex = 1
            contentView.backgroundColor = UIColor.init(hue: 0.5, saturation: 0.26, brightness: 0.76, alpha: 0.5)
        }else{
            isCOmpletedSwitch.selectedSegmentIndex = 0
            contentView.backgroundColor = UIColor.init(hue: 0.5, saturation: 0.26, brightness: 0.76, alpha: 1.0)
        }
        
        
        //makes TextView and TF uneditable
        disableScreenElements()
        
    }
    
    
}
