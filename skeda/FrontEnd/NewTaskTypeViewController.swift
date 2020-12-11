//
//  NewTaskTypeViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 8/23/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import CFAlertViewController
import DatePickerDialog

class NewTaskTypeViewController: UIViewController {

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var selectedTag: Tag?
    var delegateVC: ItemViewController?
    var taskEditMode: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CreateNewPoint"){
            let destinationVC = segue.destination as! NewPointTaskViewController
            destinationVC.taskParentTag = selectedTag
            destinationVC.delegate = delegateVC
            destinationVC.taskEditMode = taskEditMode
        }
    }
    
    
    @IBAction func pointButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "CreateNewPoint", sender: self)
    }
    
    
    
    
    
    
    
    
    
    //MARK: - Info Buttons
    
    @IBAction func pointInfoButtonPressed(_ sender: UIButton) {
        let alertVC = CFAlertViewController(title: "Single Deadline",
                                            message: "An event with one single deadline and no clear starting date, e.g. exams, essay deadlines. You are free to create as many subtasks as you like.",
                                            textAlignment: .left,
                                            preferredStyle: .alert,
                                            didDismissAlertHandler: nil)
        let doneButton = CFAlertAction(title: "OK", style: .Default, alignment: .justified, backgroundColor: UIColor(named: CONSTS.Colors.BackgroundBlue), textColor: UIColor(named: CONSTS.Colors.PseudoWhite), handler: nil)
        
        alertVC.addAction(doneButton)
        present(alertVC,animated: true,completion: nil)
        
    }
    @IBAction func lineInfoButtonPressed(_ sender: UIButton) {
        let alertVC = CFAlertViewController(title: "Full Task",
                                            message: "An event with a clear starting date and deadline/finishing date.",
                                            textAlignment: .left,
                                            preferredStyle: .alert,
                                            didDismissAlertHandler: nil)
        let doneButton = CFAlertAction(title: "OK", style: .Default, alignment: .justified, backgroundColor: UIColor(named: CONSTS.Colors.BackgroundBlue), textColor: UIColor(named: CONSTS.Colors.PseudoWhite), handler: nil)
        
        alertVC.addAction(doneButton)
        present(alertVC,animated: true,completion: nil)
    }
    @IBAction func routineInfoButtonPressed(_ sender: UIButton) {
        let alertVC = CFAlertViewController(title: "Simple Routine",
                                            message: "An event with one single deadline and no clear starting date that is set to repeat every set time interval.",
                                            textAlignment: .left,
                                            preferredStyle: .alert,
                                            didDismissAlertHandler: nil)
        let doneButton = CFAlertAction(title: "OK", style: .Default, alignment: .justified, backgroundColor: UIColor(named: CONSTS.Colors.BackgroundBlue), textColor: UIColor(named: CONSTS.Colors.PseudoWhite), handler: nil)
        
        alertVC.addAction(doneButton)
        present(alertVC,animated: true,completion: nil)
    }
    @IBAction func routineLineInfoButtonPressed(_ sender: UIButton) {
        let alertVC = CFAlertViewController(title: "Routined Full Event",
                                            message: "An event with a clear starting date and deadline/finishing date that is set to repeat every set time interval.",
                                            textAlignment: .left,
                                            preferredStyle: .alert,
                                            didDismissAlertHandler: nil)
        let doneButton = CFAlertAction(title: "OK", style: .Default, alignment: .justified, backgroundColor: UIColor(named: CONSTS.Colors.BackgroundBlue), textColor: UIColor(named: CONSTS.Colors.PseudoWhite), handler: nil)
        
        alertVC.addAction(doneButton)
        present(alertVC,animated: true,completion: nil)
    }
    
    
    


}

