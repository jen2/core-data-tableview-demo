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
    
    var tasks:[Task] = []  //2. Add an Array of managed objects here.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData() //7. The fetch method is called when the view first appears.
        taskTableView.reloadData()
    }
    
    func getData() { // 3. Add this whole function. It calls the fetch method in Core data.
        do {
            tasks = try CoreDataStack.shared.context.fetch(Task.fetch)
        }
        catch {
            // Add Alert: "Unable to fetch tasks"
            print("Error fetching tasks")
        }
    }

    //4.Add the following code inside the saveButtonTapped Action method. Look at the notes to see what is happening.
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if textField.text != "" {
            let newTask = Task(context: CoreDataStack.shared.context) // Creates a task that is managed by core data.
            
            newTask.name = textField.text!   // This sets the name of the new task to what ever is in the text field.
            
            CoreDataStack.shared.saveContext() // THIS LINE SAVES TO CORE DATA.
            
            getData() // The fetch method is called again after a new task has been saved.
            
            taskTableView.reloadData() // The table view is reloaded with all of the latest managed objects from core data. Including the new task that was just created.
            
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
        
        //5. Make sure the declaration for the cell looks just like this. Notice the cell has a new type.
        //6. Make a new file in your project called "TaskListTableViewCell." It's subclass is UITableViewCell. Go to that class.
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! TaskListTableViewCell
        
        let task = tasks[indexPath.row] //7. Add an array of Tasks. It can detect if there are managed objects saved to core data.

        
        if task.name != nil { //8.. This checks if there is a task.name for the task (double check) and then sets it to the label in the tableview.
            cell.taskLabel?.text = task.name!
        }
        
        
        return cell
    }
    
}

// 1. The method in this extension avoids an xcode error by making sure the entity name is defined. Add this variable from "extension" to  it's }.
extension Task {
    class var fetch: NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
    
    
    
    public override var description: String {
        return "Task name: \(name)"
        
    }
}






