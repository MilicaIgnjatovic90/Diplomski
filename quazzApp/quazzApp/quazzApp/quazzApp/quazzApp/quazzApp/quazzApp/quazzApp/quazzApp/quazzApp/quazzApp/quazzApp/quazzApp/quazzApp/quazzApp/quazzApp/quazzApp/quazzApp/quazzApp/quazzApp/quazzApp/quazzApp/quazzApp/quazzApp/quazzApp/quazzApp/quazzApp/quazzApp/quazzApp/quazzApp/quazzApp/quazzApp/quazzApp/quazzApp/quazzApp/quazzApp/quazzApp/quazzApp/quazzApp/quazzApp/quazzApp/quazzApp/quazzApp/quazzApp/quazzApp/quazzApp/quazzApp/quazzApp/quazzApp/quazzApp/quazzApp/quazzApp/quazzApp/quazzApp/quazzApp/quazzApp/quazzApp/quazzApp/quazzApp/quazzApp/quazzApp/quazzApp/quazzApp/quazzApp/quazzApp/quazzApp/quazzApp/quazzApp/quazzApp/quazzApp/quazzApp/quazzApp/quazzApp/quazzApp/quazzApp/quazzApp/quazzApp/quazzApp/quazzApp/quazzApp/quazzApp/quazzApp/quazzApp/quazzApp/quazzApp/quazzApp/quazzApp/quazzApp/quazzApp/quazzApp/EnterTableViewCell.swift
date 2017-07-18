//
//  EnterTableViewCell.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/4/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class EnterTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
   
    @IBOutlet weak var ans: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
