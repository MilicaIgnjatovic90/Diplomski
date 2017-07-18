//
//  AdminViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/3/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var offeredAns: UITextView!
    @IBOutlet weak var correncAns: UITextField!
    @IBOutlet weak var type: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    private func parse(txt:String) ->NSArray{
        let array: NSMutableArray = []
        var word: String = ""
        let com:Character = "|"
        
        for s in txt.characters{
            if (s != com) {
                 word = (word as String) + String(s)
            }
            else {
                array.addObject(word)
            }
        }
        return array
    }
    
    @IBAction func sendQuestion(sender: UIButton) {
    ProxyInterface.sharedInstance.postQuestion(question.text!, answers:self.parse(offeredAns.text), corectAnswer: correncAns.text!, typeOfQuestion: Int(type.text!)!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
}
