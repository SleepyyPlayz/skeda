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


class ItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
    
    
    
    
    
    
    
    
    
    
    
    /*

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
