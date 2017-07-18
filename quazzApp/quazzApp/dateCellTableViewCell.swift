//
//  dateCellTableViewCell.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/24/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class dateCellTableViewCell: UITableViewCell {

    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var  correctAns : String = " "

    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(handler), for: UIControlEvents.valueChanged)
    }
    
    func handler(_ sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        
        timeFormatter.timeStyle = DateFormatter.Style.short
        datePicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        if selectedDate.contains(correctAns) {
            Score.finalScore = Score.finalScore + 1
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
