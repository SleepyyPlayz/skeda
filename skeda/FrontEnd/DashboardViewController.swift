//
//  FirstViewController.swift
//  skeda
//
//  Created by Sleepyy on 7/13/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import PopMenu
import DatePickerDialog
import CoreData
import SwipeCellKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate, canLoadTasks, UITabBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var instructionTextView: UITextView!
    
    var tasks = [Task]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dateKeyForEdit: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        
        loadTasks()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTasks()
    }
    
    @IBAction func unwindToItemVC(segue: UIStoryboardSegue){
        
    }
    
    func loadTasks(){
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            tasks = try context.fetch(request)
        } catch {
            print("Error loading tasks for dashboard \(error)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        if tasks.count == 0{
            instructionTextView.isHidden = false
        }else{
            instructionTextView.isHidden = true
        }
    }
    
    func saveTasks(){
        do{
            try context.save()
        }catch{
            print("Error saving tasks \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DashToEditPointTask"{
            let destinationVC = segue.destination as! NewPointTaskViewController
            //destinationVC.taskParentTag =
            destinationVC.delegate = self
            destinationVC.taskEditMode = true
            destinationVC.dateKeyForEdit = dateKeyForEdit!
            destinationVC.fromDashboard = true
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        loadTasks()
    }
    
    //MARK: - Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        let index = indexPath.row
        cell.delegate = self
        cell.backgroundBar?.backgroundColor = UIColor(named: tasks[index].themeColorName ?? CONSTS.Colors.BackgroundBlue)
        cell.whiteBackground?.isHidden = !(tasks[index].isLightThemed)
        
        cell.titleLabel?.text = (tasks[index].parentTag?.title)! + " - " + tasks[index].title!
        //cell.titleLabel?.font = UIFont(name: "SanFranciscoText-Light",size: 24)
        
        cell.priorityIcon?.image = UIImage(named: ("Priority" + String(tasks[index].importance)))
        
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
        
        //deadline date formatting
        let daysLeft = Calendar.current.dateComponents([.day], from: Date(), to: tasks[index].dateDeadline!).day
        if daysLeft! == 0{
            cell.deadlineLabel?.text = "DUE TODAY!"
            cell.deadlineLabel?.textColor = UIColor(named: CONSTS.Colors.WarningRed)
        }else if daysLeft! > 0{
            if daysLeft == 1{
                cell.deadlineLabel?.text = "Due in " + String(daysLeft!) + " Day"
                //cell.deadlineLabel?.textColor = UIColor(named: CONSTS.Colors.WarningRed)
            }else{
                cell.deadlineLabel?.text = "Due in " + String(daysLeft!) + " Days"
                //cell.deadlineLabel?.textColor = UIColor(named: CONSTS.Colors.WarningRed)
            }
        }else{
            if daysLeft == -1{
                cell.deadlineLabel?.text = String(abs(daysLeft!)) + " DAY OVERDUE!"
                cell.deadlineLabel?.textColor = UIColor(named: CONSTS.Colors.WarningRed)
            }else{
                cell.deadlineLabel?.text = String(abs(daysLeft!)) + " DAYS OVERDUE!"
                cell.deadlineLabel?.textColor = UIColor(named: CONSTS.Colors.WarningRed)
            }
        }
        
        //subtask number label determiner
        var sSubtasks = [Subtask]()
        let sRequest: NSFetchRequest<Subtask> = Subtask.fetchRequest()
        let sPredicate = NSPredicate(format: "abs(parentTask.dateKey - %lf) < 0.001", tasks[index].dateKey)
        sRequest.predicate = sPredicate
        do {
            sSubtasks = try context.fetch(sRequest)
        } catch {
            print("Error loading subtasks for counting \(error)")
        }
        if sSubtasks.count == 0{
            cell.subtaskLabel?.text = "No Subtasks"
        }else{
            let sSubtasksSorted = sSubtasks.sorted { (SubtaskFirst, SubtaskSecond) -> Bool in
                let delta = SubtaskFirst.dateDeadline?.timeIntervalSince(SubtaskSecond.dateDeadline!)
                return (delta! < 0)
            }
            cell.subtaskLabel?.text = sSubtasksSorted[0].title
        }
        
        //reminder number label determiner
        var rReminders = [Reminder]()
        let rRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        let rPredicate = NSPredicate(format: "abs(parentTask.dateKey - %lf) < 0.001", tasks[index].dateKey)
        rRequest.predicate = rPredicate
        do {
            rReminders = try context.fetch(rRequest)
        } catch {
            print("Error loading reminders for counting \(error)")
        }
        if rReminders.count == 1{
            cell.reminderLabel?.text = "1 Reminder"
        }else{
            cell.reminderLabel?.text = (String(rReminders.count) + " Reminders")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let editAction = SwipeAction(style: .default, title: nil) { (action, indexPath) in
            //to edit interface
            //self.editMarker = true
            
            self.dateKeyForEdit = self.tasks[indexPath.row].dateKey
            self.performSegue(withIdentifier: "DashToEditPointTask", sender: self.self)
            
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
        //... inspection
        //performSegue ...
        dateKeyForEdit = tasks[indexPath.row].dateKey
        performSegue(withIdentifier: "DashToEditPointTask", sender: self.self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Sorting Menu
    
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        
        //Create Actions for the Menu
        var sortMethodViewActions : [PopMenuDefaultAction] = []
        
        //PopMenuDefaultAction(title: String?, image: UIImage?, color: Color?, didSelect: PopMenuActionHandler func (can also be closure) )
        sortMethodViewActions.append(PopMenuDefaultAction(title: "Smart Sort", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
            
            self.tasks.sort { (TaskFirst, TaskSecond) -> Bool in
                let delta = TaskFirst.dateDeadline?.timeIntervalSince(TaskSecond.dateDeadline!)
                
                if delta! == 0{
                    return TaskFirst.importance > TaskSecond.importance
                }else{
                    return (delta! < 0)
                }
            }
            
            self.saveTasks()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }))
        sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Due Date", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
            
            self.tasks.sort { (TaskFirst, TaskSecond) -> Bool in
                let delta = TaskFirst.dateDeadline?.timeIntervalSince(TaskSecond.dateDeadline!)
                return (delta! < 0)
            }
            
            self.saveTasks()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }))
        sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Importance", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
            
            self.tasks.sort { (TaskFirst, TaskSecond) -> Bool in
                return TaskFirst.importance > TaskSecond.importance
            }
            self.saveTasks()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }))
        sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Date Created", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
            
            self.tasks.sort { (TaskFirst, TaskSecond) -> Bool in
                return TaskFirst.dateKey > TaskSecond.dateKey
            }
            self.saveTasks()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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

