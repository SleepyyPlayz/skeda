//
//  NewTagViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 7/21/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit

class NewTagViewController: UIViewController {
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
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        
        //Set gesture recognizer for dismissing keyboard upon clicking outside keyboard!!!
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        initializeFields()
        
        
    }
    
    func initializeFields(){
        blueButtonSelected(blueButton)
    }

}

//MARK: - TextField delegate
extension NewTagViewController: UITextFieldDelegate{
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
}

//MARK: - Color Buttons
extension NewTagViewController{
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
    }
    @IBAction func PurpleLTButtonSelected(_ sender: UIButton) {
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
    }
}
