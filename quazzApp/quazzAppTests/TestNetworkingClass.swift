//
//  TestNetworkingClass.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 2/17/17.
//  Copyright © 2017 Milica Ignjatović. All rights reserved.
//

import XCTest
@testable import quazzApp

class TestNetworkingClass: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginFuncTrue() {
        let retVal = ProxyInterface.sharedInstance.loginFunc("Test", password: "test")
        waitForExpectations(timeout: 20, handler: nil)

        XCTAssertEqual(retVal,"True")
    }
    
    func testLoginFuncFalse() {
        let retVal = ProxyInterface.sharedInstance.loginFunc("npr", password: "npr")
        XCTAssertEqual(retVal,"False")
    }
    
    func testRegisterFuncTrue() {
        let retVal = ProxyInterface.sharedInstance.registerFunc("Test", password: "test", email: "test@gmail.com")
        XCTAssertEqual(retVal,"True")
    }
    
    func testRegisterFuncFalse() {
        let retVal =  ProxyInterface.sharedInstance.registerFunc("Test", password: "test", email: "test@gmail.com")
        XCTAssertEqual(retVal,"False")
    }
    
    func testPostScoreTrue() {
        let retVal =  ProxyInterface.sharedInstance.postScoreFunc("Test", score: "8")
        XCTAssertEqual(retVal,"True")
    }
    
    func testPostScoreFalse() {
        let retVal =  ProxyInterface.sharedInstance.postScoreFunc("npr", score: "8")
        XCTAssertEqual(retVal,"False")
    }

    func testScoreFuncFalse() {
        let retVal =  ProxyInterface.sharedInstance.scoreFunc("npr", password: "npr")
        XCTAssertEqual(retVal,"False")
    }
    
    func testScoreFuncTrueWrongValue() {
        let retVal =  ProxyInterface.sharedInstance.scoreFunc("npr", password: "npr")
        XCTAssertNotEqual(retVal,"10")
    }

    func testScoreFuncTrue() {
        let retVal =  ProxyInterface.sharedInstance.scoreFunc("npr", password: "npr")
        XCTAssertEqual(retVal,"8")
    }
    
    func testReturnQuestionsTrue() {
        let retVal =  ProxyInterface.sharedInstance.returnQuestions()
        XCTAssertEqual(retVal.count,4)
    }
    
    func testReturnQuestionsFalse() {
        let retVal =  ProxyInterface.sharedInstance.returnQuestions()
        XCTAssertNotEqual(retVal.count,5)
    }
    
    func test_GET_ReturnsData() {
        
        let data = ProxyInterface.sharedInstance.returnQuestions()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(data)
    }
    
    func testPerformanceExample() {
        self.measure {
            let retVal =  ProxyInterface.sharedInstance.scoreFunc("npr", password: "npr")
            XCTAssertNotEqual(retVal,"8")
        }
    }
    
}
