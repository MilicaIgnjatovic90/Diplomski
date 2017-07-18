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
    
    var  correctAns : String = " "

    override func awakeFromNib() {
        super.awakeFromNib()
        self.ans.addTarget(
            self,
            action: #selector(score),
            for: UIControlEvents.editingChanged
        )
    }
    
    func score(){
        if ans.text!.lowercased().isEqual(correctAns.lowercased()){
            Score.finalScore = Score.finalScore + 1
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
