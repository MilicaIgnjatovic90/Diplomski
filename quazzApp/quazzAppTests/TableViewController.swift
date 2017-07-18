//
//  TableViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 2/17/17.
//  Copyright © 2017 Milica Ignjatović. All rights reserved.
//

import XCTest
@testable import quazzApp

class TableViewController: XCTestCase {
    var storyboard = UIStoryboard(name: "Main", bundle:nil)
    var vc: UserTableViewController? = nil

    override func setUp() {
        super.setUp()
        storyboard = UIStoryboard(name: "Main", bundle:nil)
        vc = storyboard.instantiateViewController(withIdentifier: "UserTableViewController_ID") as? UserTableViewController
    }
    
    override func tearDown() {
       self.vc = nil
        super.tearDown()
    }
    
    // View loading tests
    func testThatViewLoads()
    {
        XCTAssertNotNil(self.vc?.view, "View not initiated properly");
    }
    
    
    func testThatTableViewLoads()
    {
        XCTAssertNotNil(self.vc?.tableView, "TableView not initiated");
    }
    
    //UITableView tests
    func testThatViewConformsToUITableViewDataSource()
    {
        XCTAssertTrue((self.vc?.tableView.dataSource)! as UITableViewDataSource as! Bool)
    }
    
    func testThatTableViewHasDataSource()
    {
        XCTAssertNotNil(self.vc?.tableView.dataSource, "Table datasource cannot be nil");
    }
    
    func testThatViewConformsToUITableViewDelegate()
    {
        XCTAssertTrue((self.vc?.tableView.delegate)! as UITableViewDelegate as! Bool, "View does not conform to UITableView delegate protocol")
    }
    
   func testTableViewIsConnectedToDelegate()
    {
        XCTAssertNotNil(self.vc?.tableView.delegate, "Table delegate cannot be nil")
    }
    
   func testTableViewNumberOfRowsInSection()
    {
        let expectedRows = 4;
        XCTAssertTrue(self.vc!.tableView.numberOfRows(inSection: 0)==expectedRows)
    }
    
    func testTableViewHeightForRowAtIndexPath()
    {
        let expectedHeight:CGFloat = 44
        let actualHeight = self.vc?.tableView.rowHeight
        XCTAssertEqual(expectedHeight, actualHeight)
    }
    
   func testTableViewCellCreateCellsWithReuseIdentifier()
    {
//    let indexPath = NSIndexPath(0,0)
//    let cell = self.vc.tableView.cellForRowAtIndexPath(indexPath)
//    NSString *expectedReuseIdentifier = [NSString stringWithFormat:@"%ld/%ld",(long)indexPath.section,(long)indexPath.row];
//    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
