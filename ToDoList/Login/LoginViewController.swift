//
//  LoginViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import UIKit

class LoginViewController: BaseViewController{

    var lvm = LoginViewModel.init()
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets text field delegates
        usernameTF.delegate = self
        passwordTF.delegate = self
        
     
    }
    
    #warning("make an error function in view model")
    //pushes listViewController on login button push
    @IBAction func login(_ sender: UIButton) {
        if usernameTF.text != "" && passwordTF.text != ""{
            let st = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = st.instantiateViewController(identifier: ViewControllerConstants.CListViewController)
            navigationController?.pushViewController(vc, animated: true)
        }else {
            if usernameTF.text == "" {
                usernameTF.changeBorderColor(borderWidth: 5, color: .red)
            }
            if passwordTF.text == "" {
                passwordTF.changeBorderColor(borderWidth: 5, color: .red)
            }
        }
    
       
    }
    
    


}




extension LoginViewController{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.tag == 1{
            let userNameIsValid = lvm.isGreaterThanLimit(string: usernameTF.text!)
            if userNameIsValid == false{
                usernameTF.changeBorderColor(borderWidth: 5, color: UIColor.red)
            }else{
                usernameTF.removeBorder()
            }
            lvm.editUsername(changeTo: textField.text!)
        }else if textField.tag == 2{
            let passwordIsValid = lvm.isGreaterThanLimit(string: passwordTF.text!)
            if passwordIsValid == false{
                passwordTF.changeBorderColor(borderWidth: 5, color: UIColor.red)
            }else{
                passwordTF.removeBorder()
            }
            lvm.editPassword(changeTo: textField.text!)
        }

    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        return true
//    }
    
    
}
