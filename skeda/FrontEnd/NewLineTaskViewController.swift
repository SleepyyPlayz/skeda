//
//  NewLineTaskViewController.swift
//  skeda
//
//  Created by 蒋汪正 on 10/10/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import CoreData
import CFAlertViewController
import DatePickerDialog

class NewLineTaskViewController: UIViewController {

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
    }
}
