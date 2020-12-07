//
//  TaskTableViewCell.swift
//  skeda
//
//  Created by 蒋汪正 on 12/6/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import SwipeCellKit

class TaskTableViewCell: SwipeTableViewCell {
    
    @IBOutlet var backgroundBar: UIView!
    @IBOutlet var whiteBackground: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priorityIcon: UIImageView!
    
    @IBOutlet weak var deadlineIcon: UIImageView!
    let deadlineDateFormatter = DateFormatter()
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var subtaskIcon: UIImageView!
    @IBOutlet weak var subtaskLabel: UILabel!
    
    @IBOutlet weak var reminderIcon: UIImageView!
    @IBOutlet weak var reminderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        deadlineDateFormatter.dateFormat = "MMMM dd, yyyy"
        
        backgroundBar.layer.cornerRadius = 5
        whiteBackground.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
