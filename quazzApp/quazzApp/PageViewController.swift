//
//  PageViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/17/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//


import UIKit
    
class AdminViewPageViewController: UIPageViewController {
        
    weak var adminViewDelegate: AdminViewPageViewControllerDelegate?
        
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController("Admin"),
                self.newViewController("AddUser"),
                self.newViewController("Score")]
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        dataSource = self
        delegate = self
            
        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }
            
        adminViewDelegate?.adminViewPageViewController(self, didUpdatePageCount: orderedViewControllers.count)
    }
        

    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }
        
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }
        
    fileprivate func newViewController(_ nameVC: String) -> UIViewController {
        
        return UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier: "\(nameVC)ViewController_ID")
    }
    
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                            direction: direction,
                            animated: true,
                            completion: { (finished) -> Void in
                            self.notifyAdminViewDelegateOfNewIndex()
        })
    }
        
    
    fileprivate func notifyAdminViewDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            adminViewDelegate?.adminViewPageViewController(self,
                                                             didUpdatePageIndex: index)
        }
    }
        
}

extension AdminViewPageViewController: UIPageViewControllerDataSource {
        
    func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
        }
            
        let previousIndex = viewControllerIndex - 1
            
          
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
            
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
            
        return orderedViewControllers[previousIndex]
    }
        
    func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
            
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
            
            
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
            
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
            
        return orderedViewControllers[nextIndex]
    }
        
}
    
extension AdminViewPageViewController: UIPageViewControllerDelegate {
        
    func pageViewController(_ pageViewController: UIPageViewController,
                                didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController],
                                transitionCompleted completed: Bool) {
        notifyAdminViewDelegateOfNewIndex()
    }
        
}
    
protocol AdminViewPageViewControllerDelegate: class {
        
    func adminViewPageViewController(_ adminViewPageViewController: AdminViewPageViewController,
                                        didUpdatePageCount count: Int)
        
    func adminViewPageViewController(_ adminViewPageViewController: AdminViewPageViewController,
                                        didUpdatePageIndex index: Int)
        
}

