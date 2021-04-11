//
//  AddViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import UIKit

protocol fillToDoCell{
    func fillCell(title: String, description: String, deadline: String, index: Int?)
}

class AddViewController: BaseViewController {
    
    let avm = AddViewModel.init()
    
    var delegate: fillToDoCell?
    
    var datePick = datePicker.init()
    
    //Add button and it's text var
    @IBOutlet weak var add_editButton: UIButton!
    
    
    //index of cell that was swiped
    var cellBeingEdited: Int?
    
    //date picker outlet
    @IBOutlet weak var datpicker: UIPickerView!
    
    //Text field outlets
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var deadlineText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets delegates for text fields
        titleText.delegate = self
        descriptionText.delegate = self
        deadlineText.delegate = self
        
        //removes keyboard when deadline text field is clicked
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        deadlineText.addGestureRecognizer(tap1)
        
        //when a cell is edited, fills in existing cell values
        setExistingValuesPart2()
        
        //sets text of add_editButton
        add_editButton.setTitle(avm.buttonTitle, for: .normal)
    }

   
    //sends command to add or edit toDoArray
    @IBAction func add(_ sender: UIButton) {
        let arrOfVcs = navigationController?.viewControllers
        for vc in arrOfVcs!{
            if vc is ListViewController {
                delegate?.fillCell(title: titleText.text ?? "", description: descriptionText.text ?? "", deadline: deadlineText.text ?? "", index: cellBeingEdited)
                navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
    }
    
    //sets btn title variable in avm
    func setBtnTitlePart1(title: String){
        avm.buttonTitle = title
    }
    
    //fills AddVC with existing values for swiped cell
    func setExistingValuesPart1(myObj: ToDo){
        avm.tempTile = myObj.title
        avm.tempDescrip = myObj.description
        avm.tempDeadline = myObj.deadline
    }

    //sets text field text to value of existing variables in avm
    func setExistingValuesPart2(){
        titleText.text = avm.tempTile
        descriptionText.text = avm.tempDescrip
        deadlineText.text = avm.tempDeadline
        avm.tempTile = nil
        avm.tempDescrip = nil
        avm.tempDeadline = nil
    }
    
}





extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return datePick.months.count
        } else if component == 1{
            return datePick.days.count
        } else {
            return datePick.years.count
        }
    }
    
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch component{
        case 0:
            datePick.month = datePick.months[row]
        case 1:
            datePick.day = String(datePick.days[row])
        default:
            datePick.year = String(datePick.years[row])
        }
        let date = "\(datePick.month) \(datePick.day) \(datePick.year)"
        deadlineText.text = date
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return datePick.months[row]
        case 1:
            return String(datePick.days[row])
        case 2:
            return String(datePick.years[row])
        default:
            return String(0)
        }
    }
}
