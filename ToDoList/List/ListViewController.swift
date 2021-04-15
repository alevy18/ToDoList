//
//  ListViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import UIKit
import CoreData


class ListViewController: BaseViewController, fillToDoCell, SendCompletedInfo{

    @IBOutlet weak var toDoList: UITableView!
       
    let myToDoList = ToDoList.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myToDoList.convertToToDos()
        
        toDoList.delegate = self
        toDoList.dataSource = self
            
        
        //adds plus bar button item
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        navigationItem.rightBarButtonItem = addButton
        
        //adds settings bar button item
        let settingsButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSettings))
        navigationItem.leftBarButtonItem = settingsButton
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        CD.shared.loadSavedDataToTable { (arr, error) in
            self.myToDoList.toDoArray = arr ?? []
            self.toDoList.reloadData()
        }
    }
    
    @objc func openSettings(){
        let vc = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    

    #warning("make a common method")
    //pushes AddViewController
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: ViewControllerConstants.CAddViewController) as! AddViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    #warning("should be a separate method in vm")
    //appends a new ToDo object to the ToDoArray in the vm
    func fillCell(title: String, description: String, deadline: String, index: Int?) {
        myToDoList.addToDo(title: title, description: description, deadline: deadline, index: index) {
            CD.shared.loadSavedDataToTable { (arr, error) in
                self.myToDoList.toDoArray = arr!
            }
            self.toDoList.reloadData()
        }
        
        //reloading the data here stops lag from data upload on view did apear
        //toDoList.reloadData()
    }
    
    
    //reloads the table view when segmented control is changed. Causes cell alpha to change on switch.
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
    
    #warning("need to add fucntionality into core data and reload data")
    //opens buttons for edit and delete on side swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //retrieves cell from ToDoArray
        let cellToEdit = self.myToDoList.getToDo(index: indexPath.row)
        
        let edit = UIContextualAction.init(style: .normal, title: "Edit") { (action, view, completion) in
            
            //pushes AddViewCOntroller
            let st = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = st.instantiateViewController(identifier: ViewControllerConstants.CAddViewController) as! AddViewController
            //fill cell delegate
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            //sets existing values in AddVC text fields
            vc.editObj = cellToEdit
            //sets cellBeingEdited to the index of toDoArray of the cell
            vc.cellBeingEdited = indexPath.row
            
            //changes button title
            vc.btnTitle = "Edit"
            
        }
        
        let delete = UIContextualAction.init(style: .destructive, title: "Delete") { (action, view, completion) in
            
            
            CD.shared.appDelegate.persistentContainer.viewContext.delete(cellToEdit)
            CD.shared.appDelegate.saveContext()
            CD.shared.loadSavedDataToTable { (arr, error) in
                self.myToDoList.toDoArray = arr!
            }
            
            
            self.toDoList.reloadData()
            
        }
        
        edit.backgroundColor = .systemYellow
        delete.backgroundColor = .systemRed
        
        let swipeButtons = UISwipeActionsConfiguration.init(actions: [delete, edit])
        swipeButtons.performsFirstActionWithFullSwipe = false
        
        return swipeButtons
    }
    
   
}

