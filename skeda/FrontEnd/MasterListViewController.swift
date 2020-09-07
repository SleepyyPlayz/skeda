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

class MasterListViewController: UIViewController, canLoadTags, SwipeTableViewCellDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var tags = [Tag]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var newTagView = NewTagViewController()  OLD CODE

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TagTableViewCell", bundle: nil), forCellReuseIdentifier: "TagCell")
        //newTagView.delegate = self    OLD CODE
        
        loadTags()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTags()
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear()
        
    }*/
    
    //load tags from database into array
    func loadTags() {
        let request : NSFetchRequest<Tag> = Tag.fetchRequest()

        do{
            tags = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        tableView.reloadData()

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
    }
    
    //MARK: - Sort Button Functionality
    
    @IBAction func sortButtonPressedInMaster(_ sender: UIButton) {
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

extension MasterListViewController: UITableViewDataSource, UITableViewDelegate{
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
            //...
        }
        editAction.image = UIImage(named: "EditButton")
        editAction.backgroundColor = UIColor(named: CONSTS.Colors.PseudoWhite)
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        //segue to task list (+query by category)
    }
    
    
    
}
