//
//  EditTagViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 9/7/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import CoreData
import CFAlertViewController

protocol canEdit {
    func loadTagsFromEdit()
    // func update Tag and delete Tag??? 
}

class EditTagViewController: UIViewController, UITextFieldDelegate {
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
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priorityBar: UISegmentedControl!
    
    
    var tags = [Tag]()
    var indexForEdit: Int?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var delegate: canEdit?
    
    //temporary variables for use, matches tag data structure.
    var tagPriority: Int?
    var tagThemeColorName: String?
    var tagIsLightThemed: Bool?
    var tagTitle: String?
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        
        //gesture for dismissing keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        //load tags tag array first,
        loadTags()
        //then load data into temp variables and the screen.
        do{
            try initializeFields()
        } catch {
            print("error initializing edit screen: \(error)")
        }
    }
    
    //load tags from database into array
    func loadTags() {
        let request : NSFetchRequest<Tag> = Tag.fetchRequest()
        do{
            tags = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
    }
    //save data to database
    func saveTags() {
        do {
            try context.save()
        } catch {
            print("Error saving tags \(error)")
        }
    }
    
    
    //MARK: - initialize elements on the interface
    func initializeFields() throws{
        //1st section: load values into temp variables
        guard((indexForEdit) != nil) else {
            throw CONSTS.VariableNullErrors.indexForEditIsNull
        }
        tagTitle = tags[indexForEdit!].title
        tagPriority = Int(tags[indexForEdit!].priority)
        tagThemeColorName = tags[indexForEdit!].themeColorName
        tagIsLightThemed = tags[indexForEdit!].isLightThemed
        
        //2nd section: display data onto screen
        titleTextField.text = tagTitle
        priorityBar.selectedSegmentIndex = tagPriority!
        warningLabel.isHidden = true
        if(!tagIsLightThemed!){
            switch tagThemeColorName{
            case CONSTS.Colors.BackgroundBlue:
                blueButtonSelected(blueButton)
            case CONSTS.Colors.BackgroundGreen:
                greenButtonSelected(greenButton)
            case CONSTS.Colors.BackgroundTurquoise:
                turquoiseButtonSelected(turquoiseButton)
            case CONSTS.Colors.BackgroundGrey:
                greyButtonSelected(greyButton)
            case CONSTS.Colors.BackgroundDeepBlue:
                deepBlueButtonSelected(deepBlueButton)
            case CONSTS.Colors.BackgroundPurple:
                purpleButtonSelected(purpleButton)
            case CONSTS.Colors.BackgroundOrange:
                orangeButtonSelected(orangeButton)
            case CONSTS.Colors.BackgroundRed:
                redButtonSelected(redButton)
            default:
                throw CONSTS.VariableNullErrors.noColorFound
            }
        }else{
            switch tagThemeColorName{
            case CONSTS.Colors.BackgroundBlue:
                blueLTButtonSelected(blueLTButton)
            case CONSTS.Colors.BackgroundGreen:
                greenLTButtonSelected(greenLTButton)
            case CONSTS.Colors.BackgroundTurquoise:
                turquoiseLTButtonSelected(turquoiseLTButton)
            case CONSTS.Colors.BackgroundGrey:
                greyLTButtonSelected(greyLTButton)
            case CONSTS.Colors.BackgroundDeepBlue:
                deepBlueLTButtonSelected(deepBlueLTButton)
            case CONSTS.Colors.BackgroundPurple:
                purpleLTButtonSelected(purpleLTButton)
            case CONSTS.Colors.BackgroundOrange:
                orangeLTButtonSelected(orangeLTButton)
            case CONSTS.Colors.BackgroundRed:
                redLTButtonSelected(redLTButton)
            default:
                throw CONSTS.VariableNullErrors.noColorFound
            }
        }
        
    }
    
    //MARK: - when user clicks on priority bar
    @IBAction func priorityBarChanged(_ sender: UISegmentedControl) {
        tagPriority = sender.selectedSegmentIndex
    }
    
    //MARK: - Done Button Pressed: saves changes
    @IBAction func doneButtonPressed(_ sender: UIButton) {
    }
    
    //MARK: - Delete Button Pressed
    //Pops up alert saying either list is not empty can't delete, or an alert confirming action
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
    }
    
    
    //MARK: - Text Field Functionality
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    //fuction that co-ops with the gesture recognizer in ViewDidLoad
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    //TODO: CoreData functionality???
    
   
}

//MARK: - Color Buttons
extension EditTagViewController{
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        tagThemeColorName = CONSTS.Colors.BackgroundBlue
        tagIsLightThemed = false
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        tagThemeColorName = CONSTS.Colors.BackgroundGreen
        tagIsLightThemed = false
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        tagThemeColorName = CONSTS.Colors.BackgroundTurquoise
        tagIsLightThemed = false
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        tagThemeColorName = CONSTS.Colors.BackgroundGrey
        tagIsLightThemed = false
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        tagThemeColorName = CONSTS.Colors.BackgroundDeepBlue
        tagIsLightThemed = false
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        tagThemeColorName = CONSTS.Colors.BackgroundPurple
        tagIsLightThemed = false
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        tagThemeColorName = CONSTS.Colors.BackgroundOrange
        tagIsLightThemed = false
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.PseudoWhite)
        tagThemeColorName = CONSTS.Colors.BackgroundRed
        tagIsLightThemed = false
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundBlue)
        tagThemeColorName = CONSTS.Colors.BackgroundBlue
        tagIsLightThemed = true
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGreen)
        tagThemeColorName = CONSTS.Colors.BackgroundGreen
        tagIsLightThemed = true
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundTurquoise)
        tagThemeColorName = CONSTS.Colors.BackgroundTurquoise
        tagIsLightThemed = true
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundGrey)
        tagThemeColorName = CONSTS.Colors.BackgroundGrey
        tagIsLightThemed = true
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundDeepBlue)
        tagThemeColorName = CONSTS.Colors.BackgroundDeepBlue
        tagIsLightThemed = true
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundPurple)
        tagThemeColorName = CONSTS.Colors.BackgroundPurple
        tagIsLightThemed = true
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundOrange)
        tagThemeColorName = CONSTS.Colors.BackgroundOrange
        tagIsLightThemed = true
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
        themeLabel.textColor = UIColor(named: CONSTS.Colors.BackgroundRed)
        tagThemeColorName = CONSTS.Colors.BackgroundRed
        tagIsLightThemed = true
    }
}
