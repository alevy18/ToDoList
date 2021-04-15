//
//  SettingsViewController.swift
//  ToDoList
//
//  Created by Aaron Levy on 4/15/21.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsCell
        return cell
    }
    

    @IBOutlet weak var SettingsTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "SettingsCell", bundle: nil)
        SettingsTblView.register(nib, forCellReuseIdentifier: "cell")
        

    }




}
