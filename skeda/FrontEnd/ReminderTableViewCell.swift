//
//  ReminderTableViewCell.swift
//  skeda
//
//  Created by 蒋汪正 on 10/12/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import SwipeCellKit

class ReminderTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
