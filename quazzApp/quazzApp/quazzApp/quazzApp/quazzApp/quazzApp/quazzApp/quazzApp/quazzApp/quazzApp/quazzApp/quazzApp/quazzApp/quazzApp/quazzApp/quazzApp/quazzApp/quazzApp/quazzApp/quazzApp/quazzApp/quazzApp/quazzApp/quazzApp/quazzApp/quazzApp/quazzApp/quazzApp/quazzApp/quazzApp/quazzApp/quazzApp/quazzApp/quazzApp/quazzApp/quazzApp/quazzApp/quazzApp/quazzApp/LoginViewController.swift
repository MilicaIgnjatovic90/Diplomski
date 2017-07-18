//
//  LoginViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 8/30/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginButton(sender: UIButton) {
        ProxyInterface.sharedInstance.loginFunc(username.text!, password: password.text!)
        if (ProxyInterface.sharedInstance.isAcepted){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if username.text!.isEqual("Admin"){
                 let vc = storyboard.instantiateViewControllerWithIdentifier("AdminViewController_ID") as! AdminViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
            else{
                let vc = storyboard.instantiateViewControllerWithIdentifier("UserViewController_ID") as! UserTableViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
        }else {
            wrongData()
        }
    }
    
    func wrongData() {
        let alertController = UIAlertController(title: "Wrong data ", message:
            "Your data are not not correct, please renter your data", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
