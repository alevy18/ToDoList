//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/7/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = .gray
    }
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
        
    }
    
    deinit{
        
    }
    
}
