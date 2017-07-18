//
//  FinalViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/5/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    @IBOutlet weak var scre: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    override func viewWillAppear(_ animated: Bool) {
        scre.text = String(Score.finalScore)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
