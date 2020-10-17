//
//  NewSubtaskTableViewCell.swift
//  skeda
//
//  Created by 蒋汪正 on 10/11/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
//import SwipeCellKit

class NewSubtaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var plusSignImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
