//
//  ViewController.swift
//  Core-Data-Demo
//
//  Created by Jennifer A Sipila on 3/15/17.
//  Copyright © 2017 Jennifer A Sipila. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var tasks:[Task] = []  //2. An Array of managed objects. 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData() //7. The fetch method is called when the view first appears.
        taskTableView.reloadData()
    }
    
    func getData() { // 3.. This function calls the fetch method in Core data.
        do {
            tasks = try CoreDataStack.shared.context.fetch(Task.fetch)
        }
        catch {
            // Add Alert: "Unable to fetch tasks"
            print("Error fetching tasks")
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if textField.text != "" {
            let newTask = Task(context: CoreDataStack.shared.context) // 4. Creates a task that is managed by core data.
            
            newTask.name = textField.text!   // 5. This sets the name of the new task to what ever is in the text field.
            
            CoreDataStack.shared.saveContext() // 6. THIS LINE SAVES TO CORE DATA.
            
            getData() // 8. The fetch method is called again after a new task has been saved.
            
            taskTableView.reloadData() //9. The table view is reloaded with all of the latest managed objects from core data. Including the new task that was just created.
            
            textField.text = ""
            
        } else {
            //Add Alert: "Please add a task name."
            print("Please add a task name")
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! TaskListTableViewCell
        
        let task = tasks[indexPath.row] //10. Here an array of Tasks can detect all of the managed objects automatically.

        cell.taskLabel?.text = task.name! //11. This checks if there is a task.name for the task (double check) and then sets it to the label in the tableview.
        
        return cell
    }
    
}

extension Task {
    class var fetch: NSFetchRequest<Task> {  // 1. This extension method avoids an xcode error by making sure the entity name is defined.
        return NSFetchRequest<Task>(entityName: "Task")
    }
    
    public override var description: String {
        return "Task name: \(name)"
        
    }
}






