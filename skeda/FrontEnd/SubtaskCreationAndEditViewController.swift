//
//  SubtaskCreationAndEditViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 10/19/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import DatePickerDialog
import CFAlertViewController

protocol UpdateSubtask{
    func passSubtaskFromCreation(title: String, dueDate: Date, startDate: Date?)
    func passSubtaskFromEdit(title: String, dueDate: Date, startDate: Date?)
    func deleteSubtaskFromEdit()
}

class SubtaskCreationAndEditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var startingDateDataLabel: UILabel!
    @IBOutlet weak var dueDateDataLabel: UILabel!
    
    
    @IBOutlet weak var setStartingDateButton: UIButton!
    @IBOutlet weak var removeStartingDateButton: UIButton!
    @IBOutlet weak var setDueDateButton: UIButton!
    
    @IBOutlet weak var hiddenDeleteButton: UIButton!
    
    var editMode = false
    
    var titleForEdit: String?
    var typeTemp: String?
    var startingDateTemp: Date? = nil
    var dueDateTemp: Date = Date()
    
    var parentTaskStartingDate: Date?
    var parentTaskDueDate: Date?
    
    let formatter = DateFormatter()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: UpdateSubtask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        initializeFields()
        
        titleTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func initializeFields(){
        if !editMode{
            topLabel.text = "New Subtask"
            titleTextField.text = ""
            warningLabel.isHidden = true
            
            hiddenDeleteButton.isHidden = true
            
            startingDateTemp = nil
            startingDateDataLabel.text = "None"
            
            dueDateTemp = Date()
            dueDateDataLabel.text = formatter.string(from: dueDateTemp)
        }else{
            topLabel.text = "Edit Subtask"
            titleTextField.text = titleForEdit
            warningLabel.isHidden = true
            
            hiddenDeleteButton.isHidden = false
            
            //load target data into temp variables
            
            if(typeTemp != nil && typeTemp == CONSTS.SubtaskTypes.Point){
                startingDateDataLabel.text = "None"
                dueDateDataLabel.text = formatter.string(from: dueDateTemp)
            }else if(typeTemp != nil && typeTemp == CONSTS.SubtaskTypes.Line){
                startingDateDataLabel.text = formatter.string(from: startingDateTemp!)
                dueDateDataLabel.text = formatter.string(from: dueDateTemp)
            }
        }
    }
    
    @IBAction func removeStartingDateButtonPressed(_ sender: UIButton) {
        startingDateTemp = nil
        startingDateDataLabel.text = "None"
        typeTemp = CONSTS.SubtaskTypes.Point
    }
    
    @IBAction func editStartingDateButtonPressed(_ sender: Any) {
        typeTemp = CONSTS.SubtaskTypes.Line
        if parentTaskStartingDate != nil{
            DatePickerDialog().show("Select Starting Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: startingDateTemp ?? Date(), minimumDate: parentTaskStartingDate, maximumDate: parentTaskDueDate,  datePickerMode: .date) { (date) in
                if let dt = date{
                    self.startingDateTemp = dt
                    self.startingDateDataLabel.text = self.formatter.string(from: dt)
                }
            }
        }else{
            DatePickerDialog().show("Select Starting Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: startingDateTemp ?? Date(), maximumDate: parentTaskDueDate, datePickerMode: .date) { (date) in
                if let dt = date{
                    self.startingDateTemp = dt
                    self.startingDateDataLabel.text = self.formatter.string(from: dt)
                }
            }
        }
        
    }
    
    @IBAction func editDueDateButtonPressed(_ sender: Any) {
        if startingDateTemp != nil{
            DatePickerDialog().show("Select Due Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: dueDateTemp, minimumDate: startingDateTemp, maximumDate: parentTaskDueDate, datePickerMode: .date) { (date) in
                if let dt = date{
                    self.dueDateTemp = dt
                    self.dueDateDataLabel.text = self.formatter.string(from: dt)
                }
            }
        }else{
            DatePickerDialog().show("Select Due Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: dueDateTemp, maximumDate: parentTaskDueDate, datePickerMode: .date) { (date) in
                if let dt = date{
                    self.dueDateTemp = dt
                    self.dueDateDataLabel.text = self.formatter.string(from: dt)
                }
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if(titleTextField.text == ""){
            warningLabel.isHidden = false
        }else{
            warningLabel.isHidden = true
            
            if(!editMode){
                self.delegate?.passSubtaskFromCreation(title: titleTextField.text!, dueDate: dueDateTemp, startDate: startingDateTemp)
            }else{
                self.delegate?.passSubtaskFromEdit(title: titleTextField.text!, dueDate: dueDateTemp, startDate: startingDateTemp)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        let deleteSubtaskAlertViewController = CFAlertViewController(title: "Delete this Subtask?", message: "", textAlignment: .justified, preferredStyle: .alert, didDismissAlertHandler: nil)
        let deleteSubtaskAction = CFAlertAction(title: "Delete", style: .Destructive, alignment: .justified, backgroundColor: UIColor(named: CONSTS.Colors.WarningRed), textColor: UIColor(named: CONSTS.Colors.PseudoWhite)) { (action) in
            
            self.delegate?.deleteSubtaskFromEdit()
            self.dismiss(animated: true, completion: nil)
        }
        let deleteSubtaskCancelAction = CFAlertAction(title: "Cancel", style: .Default, alignment: .justified, backgroundColor: UIColor(named: CONSTS.Colors.BackgroundBlue), textColor: UIColor(named: CONSTS.Colors.PseudoWhite), handler: nil)
        deleteSubtaskAlertViewController.addAction(deleteSubtaskAction)
        deleteSubtaskAlertViewController.addAction(deleteSubtaskCancelAction)
        present(deleteSubtaskAlertViewController, animated: true, completion: nil)
        
    }
    
    //TextFieldDelegate functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    @objc func dismissKeyboard(){
        view.resignFirstResponder()
    }
}
