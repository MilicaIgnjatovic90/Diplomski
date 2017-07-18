//
//  CheckTableViewCell.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/4/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var cell: UIView!
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var thirdChoice: CheckBox!
    @IBOutlet weak var firstChoice: CheckBox!
    @IBOutlet weak var secondChoice: CheckBox!
    @IBOutlet weak var question: UILabel!

    var  correctAns : String = " "

    @IBAction func secondBtn(_ sender: CheckBox) {
        if ((secondLabel.text?.contains(correctAns)) != nil) {
            Score.finalScore = Score.finalScore + 1
        }
    }
    
    @IBAction func firstBtn(_ sender: CheckBox) {
        if ((firstLabel.text? .contains(correctAns)) != nil) {
            Score.finalScore = Score.finalScore + 1
        }
    }
    
    @IBAction func thirdBtn(_ sender: CheckBox) {
        if ((thirdLabel.text?.contains(correctAns)) != nil) {
            Score.finalScore = Score.finalScore + 1
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

           }

}
