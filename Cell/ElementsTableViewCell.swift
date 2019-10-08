//
//  ElementsTableViewCell.swift
//  Elements
//
//  Created by hildy abreu on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var elementNameLabel: UILabel!
    
    @IBOutlet weak var symbolWeightLabel: UILabel!
    
    @IBOutlet weak var elementImage: UIImageView!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
