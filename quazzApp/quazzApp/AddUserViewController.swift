//
//  AddUserViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/18/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {

    var retVal: String = ""
    
    @IBOutlet weak var passwordTxtAddUsr: UITextField!
    @IBOutlet weak var usernameTxtAddUsr: UITextField!

    @IBOutlet weak var emailTxtAddUsr: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        retVal = ProxyInterface.sharedInstance.registerFunc(usernameTxtAddUsr.text!, password: passwordTxtAddUsr.text!, email: emailTxtAddUsr.text!)
        if (retVal == "True"){
            self.okData()
        }else{
            if (self.retVal != ""){
                self.wrongData()
            }
        }
    }
    
    fileprivate func wrongData() {
        let alertController = UIAlertController(title: "Wrong data ", message:
            self.retVal, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    fileprivate func okData() {
        let alertController = UIAlertController(title: "User added", message:
            self.retVal, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}
