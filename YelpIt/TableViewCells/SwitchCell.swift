//
//  SwitchCell.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 1/26/18.
//  Copyright © 2018 Sudipta Bhowmik. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell : SwitchCell, switchOn : Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var catSwitch: UISwitch!
    weak var switchCellDelegate : SwitchCellDelegate?
   
    
    @IBAction func onSwitchValChange(_ sender: UISwitch) {
        print ("here")
        switchCellDelegate?.switchCell!(switchCell: self, switchOn: sender.isOn)
        
        
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
