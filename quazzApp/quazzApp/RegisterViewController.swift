//
//  RegisterViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/8/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    var retVal: String = ""
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registrationButton(_ sender: UIButton) {
        retVal = ProxyInterface.sharedInstance.registerFunc(usernameTxt.text!, password: passwordTxt.text!, email: emailTxt.text!)
        if (retVal == "True"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LogIn_ID") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
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

}
