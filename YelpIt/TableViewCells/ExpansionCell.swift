//
//  ExpansionCell.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 2/2/18.
//  Copyright © 2018 Sudipta Bhowmik. All rights reserved.
//

import UIKit

class ExpansionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var expansionLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
