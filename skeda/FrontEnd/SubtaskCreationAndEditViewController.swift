//
//  SubtaskCreationAndEditViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 10/19/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import DatePickerDialog

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
    var startingDateTemp: Date?
    var dueDateTemp: Date = Date()
    
    var parentTaskStartingDate: Date?
    var parentTaskDueDate: Date?
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        initializeFields()
        
        titleTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    func initializeFields(){
        if !editMode{
            topLabel.text = "New Subtask"
            titleTextField.text = ""
            warningLabel.isHidden = true
            
            startingDateTemp = nil
            startingDateDataLabel.text = "None"
            
            dueDateTemp = Date()
            dueDateDataLabel.text = formatter.string(from: dueDateTemp)
        }else{
            topLabel.text = "Edit Subtask"
            titleTextField.text = titleForEdit
            warningLabel.isHidden = false
            
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
    }
    
    @IBAction func editStartingDateButtonPressed(_ sender: Any) {
        if parentTaskStartingDate != nil{
            DatePickerDialog().show("Select Starting Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: parentTaskStartingDate, maximumDate: parentTaskDueDate, datePickerMode: .date) { (date) in
                if let dt = date{
                    self.startingDateTemp = dt
                    self.startingDateDataLabel.text = self.formatter.string(from: dt)
                }
            }
        }else{
            DatePickerDialog().show("Select Starting Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", maximumDate: parentTaskDueDate, datePickerMode: .date) { (date) in
                if let dt = date{
                    self.startingDateTemp = dt
                    self.startingDateDataLabel.text = self.formatter.string(from: dt)
                }
            }
        }
        
    }
    
    @IBAction func editDueDateButtonPressed(_ sender: Any) {
        if startingDateTemp != nil{
            DatePickerDialog().show("Select Due Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: startingDateTemp, maximumDate: parentTaskDueDate, datePickerMode: .date) { (date) in
                if let dt = date{
                    self.dueDateTemp = dt
                    self.dueDateDataLabel.text = self.formatter.string(from: dt)
                }
            }
        }else{
            DatePickerDialog().show("Select Due Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", maximumDate: parentTaskDueDate, datePickerMode: .date) { (date) in
                if let dt = date{
                    self.dueDateTemp = dt
                    self.dueDateDataLabel.text = self.formatter.string(from: dt)
                }
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
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
