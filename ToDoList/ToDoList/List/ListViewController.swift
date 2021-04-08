//
//  ListViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import UIKit


class ListViewController: BaseViewController, fillToDoCell, SendCompletedInfo{

    @IBOutlet weak var toDoList: UITableView!
   
    
    let myToDoList = ToDoList.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        toDoList.delegate = self
        toDoList.dataSource = self
            
        //adds plus bar button item
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        toDoList.reloadData()
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: ViewControllerConstants.CAddViewController) as! AddViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func fillCell(title: String, description: String, deadline: String) {
        myToDoList.addToDo(title: title, description: description, deadline: deadline)
    }
    
    

    
    func changeCompleteStatus(task: String) {
        toDoList.reloadData()
    }
    
   
}



extension ListViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myToDoList.numThingsToDo()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as? ToDoTableViewCell
        cell?.delegate = self
        cell?.titleLbl.text = myToDoList.getTask(index: indexPath.row)
        cell?.deadlineTxtField.text = myToDoList.getDeadline(index: indexPath.row)
        cell?.descriptionTextView.text = myToDoList.getDescription(index: indexPath.row)
        cell?.isCOmpletedSwitch.model = myToDoList.getToDo(index: indexPath.row)
        
        
        
        //makes TV and TF uneditable
        cell?.disableScreenElements()
        
        //darkens cell if marked complete
        if myToDoList.isComplete(index: indexPath.row) == true {
            cell?.contentView.backgroundColor = UIColor.init(hue: 0.5, saturation: 0.26, brightness: 0.76, alpha: 0.5)
            cell?.descriptionTextView.backgroundColor = UIColor.init(hue: 0.5
                                                                     , saturation: 0.26, brightness: 0.76, alpha: 0.5)
        }else {
            cell?.contentView.backgroundColor = UIColor.init(hue: 0.5, saturation: 0.26, brightness: 0.76, alpha: 1.0)
            cell?.descriptionTextView.backgroundColor = UIColor.init(hue: 0.5, saturation: 0.26, brightness: 0.76, alpha: 1.0)
        }
        
        return cell!
    }
    
    
}

