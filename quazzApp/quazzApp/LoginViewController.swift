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
    
    var retVal:String = ""


    @IBAction func openUserView(_ sender: AnyObject) {
        retVal = ProxyInterface.sharedInstance.loginFunc(username.text!, password: password.text!)
        if ((retVal == "True") && (!username.text!.isEqual("admin"))){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "UserTableViewController_ID")
            self.present(controller, animated: true, completion: nil)
        }else{
            if (self.retVal != ""){
                self.wrongData()
            }
        }
    }

    @IBAction func openAdminView(_ sender: UIButton) {
        retVal = ProxyInterface.sharedInstance.loginFunc(username.text!, password: password.text!)
        if ((retVal == "True") && (username.text!.isEqual("admin"))){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AdminsViewViewController_ID")
            self.present(controller, animated: true, completion: nil)
        }else{
            if (self.retVal != ""){
                self.wrongData()
            }else {
                print ("error")
            }
        }
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
         if segue.identifier == "user_segue_id" {
            let viewController:UserTableViewController = segue.destination as! UserTableViewController
            viewController.username = username.text!
        }
    }

    
    
    fileprivate func wrongData() {
        let alertController = UIAlertController(title: "Wrong data ", message:
            self.retVal, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }

}
