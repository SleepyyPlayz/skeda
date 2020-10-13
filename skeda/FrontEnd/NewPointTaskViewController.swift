//
//  NewPointTaskViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 9/27/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import CoreData
import CFAlertViewController

class NewPointTaskViewController: UIViewController{
    //BUTTONS
    
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var turquoiseButton: UIButton!
    @IBOutlet weak var greyButton: UIButton!
    @IBOutlet weak var deepBlueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueLTButton: UIButton!
    @IBOutlet weak var greenLTButton: UIButton!
    @IBOutlet weak var turquoiseLTButton: UIButton!
    @IBOutlet weak var greyLTButton: UIButton!
    @IBOutlet weak var deepBlueLTButton: UIButton!
    @IBOutlet weak var purpleLTButton: UIButton!
    @IBOutlet weak var orangeLTButton: UIButton!
    @IBOutlet weak var redLTButton: UIButton!
    
    //Color-changing Labels
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var subtasksLabel: UILabel!
    @IBOutlet weak var remindersLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priorityBar: UISegmentedControl!
    @IBOutlet weak var dueDateData: UILabel!
    @IBOutlet weak var subtasksTableView: UITableView!
    @IBOutlet weak var remindersTableView: UITableView!
    @IBOutlet weak var notesTextView: UITextView!
    
    var tasks = [Task]()
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var taskPriority: Int? = 2
    var taskThemeColorName: String?
    var taskIsLightThemed: Bool?
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
        titleTextField.delegate = self
        
        subtasksTableView.dataSource = self
        subtasksTableView.delegate = self
        subtasksTableView.register(UINib(nibName: "NewSubtaskTableViewCell", bundle: nil), forCellReuseIdentifier: "NewSubtaskCell")
        subtasksTableView.register(UINib(nibName: "PointSubtaskTableViewCell", bundle: nil), forCellReuseIdentifier: "PointSubtaskCell")
        subtasksTableView.register(UINib(nibName: "LineSubtaskTableViewCell", bundle: nil), forCellReuseIdentifier: "LineSubtaskCell")
        
        remindersTableView.delegate = self
        remindersTableView.dataSource = self
        remindersTableView.register(UINib(nibName: "NewReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "NewReminderCell")
        remindersTableView.register(UINib(nibName: "ReminderTableViewCell", bundle: nil), forCellReuseIdentifier: "ReminderCell")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        initializeFields()
        loadTasks()
        
    }
    
    func initializeFields(){
        blueButtonSelected(blueButton)
        titleTextField.text = ""
        warningLabel.isHidden = true
        priorityBar.selectedSegmentIndex = 2
        
    }
    @IBAction func priorityBarChanged(_ sender: UISegmentedControl) {
        taskPriority = sender.selectedSegmentIndex
    }
    
    func loadTasks(){
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do{
            tasks = try context.fetch(request)
        }catch{
            print("Error loading tasks \(error)")
        }
    }
    
    func saveTasks(){
        do{
            try context.save()
        }catch{
            print("Error saving tasks \(error)")
        }
    }
    
    
}

//MARK: - TextFieldDelegate
extension NewPointTaskViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

//MARK: - TextViewDelegate
extension NewPointTaskViewController: UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        <#code#>
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        <#code#>
    }
    
}
//MARK: - TableViewDelegate and DataSource

extension NewPointTaskViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 1){
            
        }else if(tableView.tag == 2){
            
        }else{
            print("ERROR Finding Table Views through tags")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView.tag == 1){
            
        }else if(tableView.tag == 2){
            
        }else{
            print("ERROR Loading Tags")
            //return nil?
        }
    }
}


//MARK: - ColorButtons

extension NewPointTaskViewController{
    @IBAction func blueButtonSelected(_ sender: UIButton) {
        sender.isSelected = true
        //blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        whiteBackground.isHidden = true
        topText.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Blue), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        taskThemeColorName = CONSTS.Colors.BackgroundBlue
        taskIsLightThemed = false
    }
    @IBAction func greenButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        sender.isSelected = true
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        whiteBackground.isHidden = true
        topText.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Green), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        taskThemeColorName = CONSTS.Colors.BackgroundGreen
        taskIsLightThemed = false
    }
    @IBAction func turquoiseButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        sender.isSelected = true
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        whiteBackground.isHidden = true
        topText.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Turquoise), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        taskThemeColorName = CONSTS.Colors.BackgroundTurquoise
        taskIsLightThemed = false
    }
    @IBAction func greyButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        sender.isSelected = true
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        whiteBackground.isHidden = true
        topText.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Grey), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        taskThemeColorName = CONSTS.Colors.BackgroundGrey
        taskIsLightThemed = false
    }
    @IBAction func deepBlueButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        sender.isSelected = true
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        whiteBackground.isHidden = true
        topText.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.DeepBlue), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        taskThemeColorName = CONSTS.Colors.BackgroundDeepBlue
        taskIsLightThemed = false
    }
    @IBAction func purpleButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        sender.isSelected = true
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        whiteBackground.isHidden = true
        topText.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Purple), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        taskThemeColorName = CONSTS.Colors.BackgroundPurple
        taskIsLightThemed = false
    }
    @IBAction func orangeButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        sender.isSelected = true
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        whiteBackground.isHidden = true
        topText.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Orange), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        taskThemeColorName = CONSTS.Colors.BackgroundOrange
        taskIsLightThemed = false
    }
    @IBAction func redButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        sender.isSelected = true
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        whiteBackground.isHidden = true
        topText.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Red), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        taskThemeColorName = CONSTS.Colors.BackgroundRed
        taskIsLightThemed = false
    }
    @IBAction func blueLTButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        sender.isSelected = true
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        whiteBackground.isHidden = false
        topText.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Blue), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        taskThemeColorName = CONSTS.Colors.BackgroundBlue
        taskIsLightThemed = true
    }
    @IBAction func greenLTButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        sender.isSelected = true
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        whiteBackground.isHidden = false
        topText.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Green), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        taskThemeColorName = CONSTS.Colors.BackgroundGreen
        taskIsLightThemed = true
    }
    @IBAction func turquoiseLTButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        sender.isSelected = true
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        whiteBackground.isHidden = false
        topText.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Turquoise), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        taskThemeColorName = CONSTS.Colors.BackgroundTurquoise
        taskIsLightThemed = true
    }
    @IBAction func greyLTButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        sender.isSelected = true
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        whiteBackground.isHidden = false
        topText.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Grey), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        taskThemeColorName = CONSTS.Colors.BackgroundGrey
        taskIsLightThemed = true
    }
    @IBAction func deepBlueLTButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        sender.isSelected = true
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        whiteBackground.isHidden = false
        topText.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.DeepBlue), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        taskThemeColorName = CONSTS.Colors.BackgroundDeepBlue
        taskIsLightThemed = true
    }
    @IBAction func purpleLTButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        sender.isSelected = true
        orangeLTButton.isSelected = false
        redLTButton.isSelected = false
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        whiteBackground.isHidden = false
        topText.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Purple), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        taskThemeColorName = CONSTS.Colors.BackgroundPurple
        taskIsLightThemed = true
    }
    @IBAction func orangeLTButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        sender.isSelected = true
        redLTButton.isSelected = false

        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        whiteBackground.isHidden = false
        topText.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Orange), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        taskThemeColorName = CONSTS.Colors.BackgroundOrange
        taskIsLightThemed = true
    }
    @IBAction func redLTButtonSelected(_ sender: UIButton) {
        blueButton.isSelected = false
        greenButton.isSelected = false
        turquoiseButton.isSelected = false
        greyButton.isSelected = false
        deepBlueButton.isSelected = false
        purpleButton.isSelected = false
        orangeButton.isSelected = false
        redButton.isSelected = false
        
        blueLTButton.isSelected = false
        greenLTButton.isSelected = false
        turquoiseLTButton.isSelected = false
        greyLTButton.isSelected = false
        deepBlueLTButton.isSelected = false
        purpleLTButton.isSelected = false
        orangeLTButton.isSelected = false
        sender.isSelected = true
        
        backgroundView.backgroundColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        whiteBackground.isHidden = false
        topText.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        closeButton.setImage(UIImage(named: CONSTS.CloseButtons.Red), for: .normal)
        titleLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        priorityLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        dueDateLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        subtasksLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        remindersLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        notesLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        taskThemeColorName = CONSTS.Colors.BackgroundRed
        taskIsLightThemed = true
    }
}


