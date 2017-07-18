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
    @IBOutlet weak var correncAns: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var offeredAns: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func sendQuestion(_ sender: UIButton) {
    let retVal = ProxyInterface.sharedInstance.postQuestion(question.text! as NSString, answers:offeredAns.text!, corectAnswer: correncAns.text! as NSString, typeOfQuestion: Int(type.text!)!)
        if (retVal == "True"){
            self.questoinSent()
        }
    }
    
    fileprivate func questoinSent() {
        let alertController = UIAlertController(title: "Question sent", message:
            "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
}
