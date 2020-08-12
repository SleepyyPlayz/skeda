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

class MasterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tags = [Tag]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        loadTags()
        
    }
    
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
        return (tags.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath) as! TagTableViewCell
        if(indexPath.row == 0){
            cell.backgroundBar?.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
            cell.whiteBackgroundBar?.isHidden = true
            cell.titleLabel?.text = "All Events"
            cell.titleLabel?.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
            cell.arrow?.image = UIImage(named: CONSTS.ArrowIcons.White)
        }else{
            let index = indexPath.row - 1
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
        }
        return cell
    }
    
    //Delegate methods:
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        //segue to task list (+query by category)
    }
    
    
    
}
