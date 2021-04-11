//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/7/21.
//

import UIKit

class BaseViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = .gray
    }
    
    //dismisses keyboard
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    //Closes keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    
    deinit{
        
    }

    
}
