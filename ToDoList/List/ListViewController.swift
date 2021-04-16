//
//  ListViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/5/21.
//

import UIKit
import CoreData
import ViewAnimator


class ListViewController: BaseViewController, SendCompletedInfo{
    
    

    @IBOutlet weak var toDoList: UITableView!
       
    let myToDoList = ToDoList.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
            
        toDoList.delegate = self
        toDoList.dataSource = self
            
        //adds plus bar button item
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        navigationItem.rightBarButtonItem = addButton
        
        //adds settings bar button item
        let settingsButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSettings))
        navigationItem.leftBarButtonItem = settingsButton
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let anim = AnimationType.random()
//        let zoomAnimation = AnimationType.zoom(scale: 0.2)
//        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
//        UIView.animate(views: toDoList.visibleCells,
//                       animations: [zoomAnimation],
//                       delay: 0.5)
//    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        CD.shared.loadSavedDataToTable { (arr, error) in
            self.myToDoList.toDoArray = arr ?? []
            self.toDoList.reloadData()
        }
        
//        let anim = AnimationType.random()
//        let zoomAnimation = AnimationType.zoom(scale: 0.2)
//        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
//        UIView.animate(views: toDoList.visibleCells,
//                       animations: [rotateAnimation /*anim, zoomAnimation*/],
//                       delay: 0.5)
    }
    
    @objc func openSettings(){
        let vc = SettingsViewController(nibName: ViewControllerConstants.CSettingsViewController, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    

    #warning("make a common method")
    //pushes AddViewController
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(identifier: ViewControllerConstants.CAddViewController) as! AddViewController
        vc.editObj = ToDoEnt.init(context: CD.shared.persistentContainer.viewContext)
        navigationController?.pushViewController(vc, animated: true)
    }

    
    //reloads the table view when segmented control is changed. Causes cell alpha to change on switch.
    func changeCompleteStatus() {
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
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            //sets existing values in AddVC text fields
            vc.editObj = cellToEdit
            
            //changes button title
            vc.btnTitle = "Edit"
            
        }
        
        let delete = UIContextualAction.init(style: .destructive, title: "Delete") { (action, view, completion) in
            
            
            CD.shared.persistentContainer.viewContext.delete(cellToEdit)
            CD.shared.saveContext()
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

