//
//  AddViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import UIKit

protocol fillToDoCell{
    func fillCell(title: String, description: String, deadline: String)
}

class AddViewController: BaseViewController {
    
    var delegate: fillToDoCell?
    
    var datePick = datePicker.init()
    
    @IBOutlet weak var datpicker: UIPickerView!
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var descriptionText: UITextField!
    
    @IBOutlet weak var deadlineText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.delegate = self
        descriptionText.delegate = self
        deadlineText.delegate = self
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard1))
        deadlineText.addGestureRecognizer(tap1)

    }
   
    
    @IBAction func add(_ sender: UIButton) {
        let arrOfVcs = navigationController?.viewControllers
        for vc in arrOfVcs!{
            if vc is ListViewController {
                delegate?.fillCell(title: titleText.text ?? "", description: descriptionText.text ?? "", deadline: deadlineText.text ?? "")
                navigationController?.popToViewController(vc, animated: true)
            }
        }
    }

}


extension AddViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    @objc func dismissKeyboard1(){
        view.endEditing(true)
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
