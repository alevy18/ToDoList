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
    
    

    
    //pushes AddViewController
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: ViewControllerConstants.CAddViewController) as! AddViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //appends a new ToDo object to the ToDoArray in the vm
    func fillCell(title: String, description: String, deadline: String, index: Int?) {
        myToDoList.addToDo(title: title, description: description, deadline: deadline, index: index)
        //reloading the data here stops lag from data upload on view did apear
        toDoList.reloadData()
    }
    
    
    //When reloads the table view when segmented control is changed. Causes cell alpha to change on switch.
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
        let myToDoObj = myToDoList.getToDo(index: indexPath.row)
        cell?.setCell(toDoObj: myToDoObj)
        cell?.delegate = self
        return cell!
    }
    
    
    //opens buttons for edit and delete on side swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction.init(style: .normal, title: "Edit") { (action, view, completion) in
            //retrieves cell from ToDoArray
            let cellToEdit = self.myToDoList.getToDo(index: indexPath.row)
            
            //pushes AddViewCOntroller
            let st = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = st.instantiateViewController(identifier: ViewControllerConstants.CAddViewController) as! AddViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
            //sets existing values in AddVC text fields
            vc.setExistingValuesPart1(myObj: cellToEdit)
            
            //sets cellBeingEdited to the index of toDoArray of the cell
            vc.cellBeingEdited = indexPath.row
            
            //changes button title
            vc.setBtnTitlePart1(title: "Edit")
            
        }
        
        let delete = UIContextualAction.init(style: .destructive, title: "Delete") { (action, view, completion) in
            
            self.myToDoList.deleteToDo(index: indexPath.row)
            self.toDoList.reloadData()
            
        }
        
        edit.backgroundColor = .systemYellow
        delete.backgroundColor = .systemRed
        
        let swipeButtons = UISwipeActionsConfiguration.init(actions: [delete, edit])
        swipeButtons.performsFirstActionWithFullSwipe = false
        
        return swipeButtons
    }
    
   
}

