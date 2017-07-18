//
//  ScoreViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/18/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var scoreLbl: UILabel!
    var retVal:String = ""
    
    
    
    @IBAction func scoreData(_ sender: UIButton) {
        retVal = ProxyInterface.sharedInstance.scoreFunc(username.text!, password: password.text!)
        if retVal == "True" {
            scoreLbl.text = retVal
        }else{
            if (self.retVal != ""){
                self.wrongData()
            }else {
                print ("error")
            }
        }
        
    }
    
    
    fileprivate func wrongData() {
        let alertController = UIAlertController(title: "Wrong data ", message:
            self.retVal, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }

}
