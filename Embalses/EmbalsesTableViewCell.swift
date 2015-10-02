//
//  EmbalsesTableViewCell.swift
//  Embalses
//
//  Created by Jorge Perez on 9/29/15.
//  Copyright © 2015 Jorge Perez. All rights reserved.
//

import UIKit

class EmbalsesTableViewCell: UITableViewCell {
    @IBOutlet var pueblo: UILabel!
    @IBOutlet var embalse: UILabel!
    @IBOutlet var metros: UILabel!
    @IBOutlet var fecha: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
