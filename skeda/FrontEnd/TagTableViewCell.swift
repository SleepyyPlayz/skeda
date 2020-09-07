//
//  TagTableViewCell.swift
//  skeda
//
//  Created by 蒋汪正 on 7/22/20.
//  Copyright © 2020 Icosa Studios. All rights reserved.
//

import UIKit
import SwipeCellKit

class TagTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var backgroundBar: UIView!
    
    @IBOutlet weak var whiteBackgroundBar: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundBar.layer.cornerRadius = (backgroundBar.frame.size.height / 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
