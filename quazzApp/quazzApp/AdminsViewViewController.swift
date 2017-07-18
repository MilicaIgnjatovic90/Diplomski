//
//  TutorialViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/18/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

class AdminsViewViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var adminViewPageViewController: AdminViewPageViewController? {
        didSet {
            adminViewPageViewController?.adminViewDelegate = self
                    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(AdminsViewViewController.didChangePageControlValue), for: .valueChanged)
    }

    @IBAction func logutButton(_ sender: UIButton) {
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let adminViewPageViewController = segue.destination as?  AdminViewPageViewController {
            self.adminViewPageViewController = adminViewPageViewController
        }
    }
    
    
    func didChangePageControlValue() {
        adminViewPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension AdminsViewViewController: AdminViewPageViewControllerDelegate {
    
    func adminViewPageViewController(_ tutorialPageViewController: AdminViewPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func adminViewPageViewController(_ tutorialPageViewController:  AdminViewPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
