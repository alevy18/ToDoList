//
//  AddViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import UIKit


class AddViewController: BaseViewController {
    
    let avm = AddViewModel.init()
    
    var editObj: ToDoEnt?
    var btnTitle: String?
    
    
    var datePick = datePicker.init()
    
    //Add button and it's text var
    @IBOutlet weak var add_editButton: UIButton!
    
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
        
        //sets text of add_editButton
        setBtnTitle()
        
        setEditValues()
    }

   
    //sends command to add or edit toDoArray
    @IBAction func add(_ sender: UIButton) {
        
        avm.toDoEntModel = editObj
        avm.toDoEntModel?.title = titleText.text ?? ""
        avm.toDoEntModel?.descrip = descriptionText.text ?? ""
        avm.toDoEntModel?.deadline = deadlineText.text ?? ""
        CD.shared.saveContext()
        
        navigationController?.popViewController(animated: true)

    }
    
    
    //sets btn title variable in avm
    func setBtnTitle(){
        if btnTitle != nil{
            avm.buttonTitle = btnTitle ?? "Add"
            btnTitle = nil
        }
        add_editButton.setTitle(avm.buttonTitle, for: .normal)
    }
    

    //fills AddVC with existing values for swiped cell
    func setEditValues(){
        avm.toDoEntModel = editObj
        titleText.text = avm.getModelTitle()
        descriptionText.text = avm.getModelDescrip()
        deadlineText.text = avm.getModelDeadline()
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
