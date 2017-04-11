//
//  SwitchCell.swift
//  Yelp
//
//  Created by Kumawat, Diwakar on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwitchCell,
        didChangeValue value:Bool)
}

class SwitchCell: UITableViewCell {

    
    @IBOutlet weak var switchLabel: UILabel!
    
    @IBOutlet weak var onSwitch: UISwitch!

    weak var delegate: SwitchCellDelegate?
    
    var model: SearchOption? {
        didSet {
            switchLabel.text = model?.title
            onSwitch.isOn = model?.isOn ?? false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func switchValueChanged() {
        if delegate != nil {
            delegate!.switchCell?(switchCell: self, didChangeValue: onSwitch.isOn)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
