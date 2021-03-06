//
//  SecondViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 7/13/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import PopMenu
import CoreData
import SwipeCellKit
import DatePickerDialog

class MasterListViewController: UIViewController, canLoadTags,canEdit{
    
    @IBOutlet weak var tableView: UITableView!
    
    var tags = [Tag]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //row index used for editing, used later
    var editIndex: Int?
    
    //var newTagView = NewTagViewController()  OLD CODE

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //debug
        print("Documents Directory: ", FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last ?? "Not Found!")
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TagTableViewCell", bundle: nil), forCellReuseIdentifier: "TagCell")
        //newTagView.delegate = self    OLD CODE
        
        loadTags()
        
    }
    
    func saveTags(){
        do{
            try context.save()
        }catch{
            print("Error saving tags \(error)")
        }
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTags()
    }*/
    
    //unwinding segue
    @IBAction func unwindToMaster(unwindSegue: UIStoryboardSegue){
        
    }
    
    //load tags from database into array
    func loadTags() {
        let request : NSFetchRequest<Tag> = Tag.fetchRequest()
        do{
            tags = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //same as previous function, called from another VC
    func loadTagsFromEdit() {
        let request : NSFetchRequest<Tag> = Tag.fetchRequest()
        do{
            tags = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - New Tag Button Pressed (Interactions with NewTagViewController)
    
    @IBAction func newTagButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "TagListToNewTag", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TagListToNewTag"){
            let destinationVC = segue.destination as! NewTagViewController
            destinationVC.delegate = self
        }
        if(segue.identifier == "TagListToEditTag"){
            let destinationVC = segue.destination as! EditTagViewController
            destinationVC.delegate = self
            if((editIndex) != nil){
                destinationVC.indexForEdit = editIndex
            }
        }
        if(segue.identifier == "MasterToItems"){
            let destinationVC = segue.destination as! ItemViewController
            //destinationVC.delegate = self
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedTag = tags[indexPath.row]
            }
        }
    }
    
    //MARK: - Sort Button Functionality
    
    @IBAction func sortButtonPressedInMaster(_ sender: UIButton) {
        var sortMethodViewActions : [PopMenuDefaultAction] = []
               
               //PopMenuDefaultAction(title: String?, image: UIImage?, color: Color?, didSelect: PopMenuActionHandler func (can also be closure) )
            sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Name", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
                self.tags.sort { (TagFirst, TagSecond) -> Bool in
                    return TagFirst.title! < TagSecond.title!
                }
                self.saveTags()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }))
            sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Importance", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
                self.tags.sort { (TagFirst, TagSecond) -> Bool in
                    return TagFirst.priority > TagSecond.priority
                }
                self.saveTags()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }))
            sortMethodViewActions.append(PopMenuDefaultAction(title: "Sort by Date Created", color: UIColor(named: CONSTS.Colors.PseudoWhite), didSelect: { (action) in
                self.tags.sort { (TagFirst, TagSecond) -> Bool in
                    return TagFirst.dateKey > TagSecond.dateKey
                }
                self.saveTags()
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

//MARK: - TableView and SwipeView functionality
extension MasterListViewController: UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate{
    //DataSource methods:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as! TagTableViewCell
        let index = indexPath.row
        cell.delegate = self
        cell.backgroundBar?.backgroundColor = UIColor(named: tags[index].themeColorName ?? CONSTS.Colors.BackgroundBlue)
        cell.whiteBackgroundBar?.isHidden = !(tags[index].isLightThemed)
        cell.titleLabel?.text = tags[index].title
        if(tags[index].isLightThemed){
            cell.titleLabel?.textColor = UIColor(named: tags[index].themeColorName ?? CONSTS.Colors.BackgroundBlue)
            switch tags[index].themeColorName {
            case CONSTS.Colors.BackgroundBlue:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.Blue)
            case CONSTS.Colors.BackgroundGreen:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.Green)
            case CONSTS.Colors.BackgroundTurquoise:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.Turquoise)
            case CONSTS.Colors.BackgroundGrey:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.Grey)
            case CONSTS.Colors.BackgroundDeepBlue:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.DeepBlue)
            case CONSTS.Colors.BackgroundPurple:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.Purple)
            case CONSTS.Colors.BackgroundOrange:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.Orange)
            case CONSTS.Colors.BackgroundRed:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.Red)
            default:
                cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.Blue)
            }
        }else{
            cell.titleLabel?.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
            cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.White)
        }
        return cell
    }
    
    //Delegate methods:
    
    //func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    //    ...
    //}
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let editAction = SwipeAction(style: .default, title: nil) { (action, indexPath) in
            self.editIndex = indexPath.row
            self.performSegue(withIdentifier: "TagListToEditTag", sender: self.self)
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
        performSegue(withIdentifier: "MasterToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
