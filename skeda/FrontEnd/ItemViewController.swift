//
//  ItemViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 8/10/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import PopMenu
import CoreData
import DatePickerDialog
import SwipeCellKit



class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [Task]()
    var selectedTag: Tag?{
        didSet{
            loadTasks()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ItemsToMaster", sender: self)
    }
    
    @IBAction func newTaskButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ItemsToNewTaskType", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ItemsToNewTaskType"){
            //...
        }
    }
    
    //MARK: - Query and load tasks
    
    func loadTasks(){
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "parentTag.dateKey MATCHES %@", selectedTag!.dateKey)
        request.predicate = predicate
        
        do {
            tasks = try context.fetch(request)
        } catch {
            print("Error loading tasks from QUERY \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        let index = indexPath.row
        cell.delegate = self
        cell.backgroundBar?.backgroundColor = UIColor(named: tasks[index].themeColorName ?? CONSTS.Colors.BackgroundBlue)
        cell.whiteBackground?.isHidden = !(tasks[index].isLightThemed)
        cell.titleLabel?.text = tasks[index].title
        cell.priorityIcon?.image = UIImage(named: ("Priority" + String(tasks[index].importance)))
        cell.deadlineLabel?.text = cell.deadlineDateFormatter.string(from: tasks[index].dateDeadline!)
        
        //subtask number label determiner
        var sSubtasks = [Subtask]()
        let sRequest: NSFetchRequest<Subtask> = Subtask.fetchRequest()
        let sPredicate = NSPredicate(format: "parentTask.dateKey", tasks[index].dateKey)
        sRequest.predicate = sPredicate
        do {
            sSubtasks = try context.fetch(sRequest)
        } catch {
            print("Error loading subtasks for counting \(error)")
        }
        if sSubtasks.count == 1{
            cell.subtaskLabel?.text = "1 Subtask"
        }else{
            cell.subtaskLabel?.text = (String(sSubtasks.count) + "Subtasks")
        }
        
        //reminder number label determiner
        var rReminders = [Reminder]()
        let rRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        let rPredicate = NSPredicate(format: "parentTask.dateKey", tasks[index].dateKey)
        rRequest.predicate = rPredicate
        do {
            rReminders = try context.fetch(rRequest)
        } catch {
            print("Error loading reminders for counting \(error)")
        }
        if rReminders.count == 1{
            cell.reminderLabel?.text = "1 Reminder"
        }else{
            cell.reminderLabel?.text = (String(rReminders.count) + "Reminders")
        }
        
        //Style determiner
        if(tasks[index].isLightThemed){
            cell.titleLabel?.textColor = UIColor(named: tasks[index].themeColorName ?? CONSTS.Colors.BackgroundBlue)
            cell.deadlineLabel?.textColor = UIColor(named: CONSTS.Colors.SubGrey)
            cell.deadlineIcon?.tintColor = UIColor(named: CONSTS.Colors.SubGrey)
            cell.subtaskLabel?.textColor = UIColor(named: CONSTS.Colors.SubGrey)
            cell.subtaskIcon?.tintColor = UIColor(named: CONSTS.Colors.SubGrey)
            cell.reminderLabel?.textColor = UIColor(named: CONSTS.Colors.SubGrey)
            cell.reminderIcon?.tintColor = UIColor(named: CONSTS.Colors.SubGrey)
        }else{
            cell.titleLabel?.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
            cell.deadlineLabel?.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
            cell.deadlineIcon?.tintColor = UIColor(named: CONSTS.Colors.PseudoWhite)
            cell.subtaskLabel?.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
            cell.subtaskIcon?.tintColor = UIColor(named: CONSTS.Colors.PseudoWhite)
            cell.reminderLabel?.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
            cell.reminderIcon?.tintColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let editAction = SwipeAction(style: .default, title: nil) { (action, indexPath) in
            //... to edit interface
            
            
            
            //self.editIndex = indexPath.row
            //self.performSegue(withIdentifier: "TagListToEditTag", sender: self.self)
        }
        editAction.image = UIImage(named: "EditButton")
        editAction.backgroundColor = UIColor(named: CONSTS.Colors.White)
        editAction.hidesWhenSelected = true
        return [editAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .none
        options.transitionStyle = .drag
        //options.backgroundColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        return options
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Segue to task inspection
    }
    
}

//MARK: - Sort Functionality

extension ItemViewController{
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        var sortMethodViewActions : [PopMenuDefaultAction] = []
        
        //PopMenuDefaultAction(title: String?, image: UIImage?, color: Color?, didSelect: PopMenuActionHandler func (can also be closure) )
        sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Name", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
            
            //PLACEHOLDER
            print("\(action.title ?? "error") was selected")
            
        }))
        sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Importance", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
            
            //PLACERHOLDER
            print("\(action.title ?? "error") was selected")
            
        }))
        sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Due Date", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
            
            //PLACEHOLDER
            print("\(action.title ?? "error") was selected")
            
        }))
        sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Date Created", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
            
            //PLACEHOLDER
            print("\(action.title ?? "error") was selected")
            
        }))
        
        
        //Create the Menu itself
        let sortMethodViewController = PopMenuViewController(sourceView: sender, actions: sortMethodViewActions)
        
        sortMethodViewController.appearance.popMenuBackgroundStyle = .blurred(.light)
        sortMethodViewController.appearance.popMenuColor.backgroundColor = .solid(fill: (UIColor(named: CONSTS.Colors.BrandAzure)!))
        sortMethodViewController.appearance.popMenuFont = .systemFont(ofSize: 20, weight: .semibold)
        sortMethodViewController.appearance.popMenuItemSeparator = .fill(UIColor(named: CONSTS.Colors.PseudoWhite)!, height: 1)
        sortMethodViewController.appearance.popMenuCornerRadius = 20
        
        present(sortMethodViewController, animated: true, completion: nil)
        
    }
}
