//
//  OptionCell.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 2/2/18.
//  Copyright © 2018 Sudipta Bhowmik. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var cellStateLabel: UILabel!
    
    struct CellState {
     
        static let Collapsed = ("b" , UIColor.lightGray, UIFont(name: "myfonts", size: 19))
        static let Checked = ("c" , UIColor.blue, UIFont(name: "myfonts", size: 19))
        static let Unchecked = ("d" , UIColor.lightGray, UIFont(name: "myfonts", size: 19))
    }
    
    
    var cellState = CellState.Collapsed {
        didSet {
            cellStateLabel?.text = cellState.0
            cellStateLabel?.textColor = cellState.1
            cellStateLabel?.font = cellState.2
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
