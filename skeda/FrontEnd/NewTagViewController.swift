//
//  NewTagViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 7/21/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit

class NewTagViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //tap.cancelsTouchesInView
        view.addGestureRecognizer(tap)
        
        
        resetFields()
        
        
    }
    
    func resetFields(){
        
    }
}

extension NewTagViewController: UITextFieldDelegate{
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
