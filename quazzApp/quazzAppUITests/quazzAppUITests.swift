//
//  quazzAppUITests.swift
//  quazzAppUITests
//
//  Created by Milica Ignjatovic on 8/29/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import XCTest

class quazzAppUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
   
    func loginOrRegistersFunc(){
        let registerButton = app.buttons["Register"]
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(app.staticTexts["Login or Register"].exists)
        XCTAssertTrue(registerButton.exists)
        XCTAssertTrue(loginButton.exists)
        XCTAssertEqual("Login", loginButton.title)
        XCTAssertEqual("Register", registerButton.title)
        XCTAssertNotEqual("Register", loginButton.title)
    }
    
    func testLoginOrRegister() {
        self.loginOrRegistersFunc()
    }
    
    func registerFunc(){
        let registerButton = app.buttons["Register"]
        registerButton.tap()
        XCTAssertTrue(app.staticTexts["Please enter your data"].exists)
        XCTAssertTrue(app.staticTexts["Username"].exists)
        XCTAssertTrue(app.staticTexts["Password"].exists)
        XCTAssertTrue(app.staticTexts["E - mail"].exists)
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let element = window.children(matching: .other).element.children(matching: .other).element
        XCTAssertTrue(element.children(matching: .textField).element(boundBy: 0).exists)
        XCTAssertTrue(element.children(matching: .textField).element(boundBy: 1).exists)
        XCTAssertTrue(element.children(matching: .textField).element(boundBy: 2).exists)
        

    }
    func testRegister() {
        self.registerFunc()
    }
    
    func loginFunc(){
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        XCTAssertTrue(app.staticTexts["Enter username and password"].exists)
        XCTAssertTrue(app.staticTexts["Username"].exists)
        XCTAssertTrue(app.staticTexts["Password"].exists)
        XCTAssertTrue(app.buttons["Login As Admin"].exists)
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        XCTAssertTrue(element.children(matching: .textField).element(boundBy: 0).exists)
        XCTAssertTrue(element.children(matching: .textField).element(boundBy: 1).exists)
        XCTAssertTrue(loginButton.exists)
    }
    
    
    func testLogin(){
        self.loginFunc()
    }
    
    func firstScreen(){
        
        XCTAssertTrue(app.buttons["Logout"].exists)
        XCTAssertTrue(app.staticTexts["Question"].exists)
        XCTAssertTrue(app.staticTexts["Type of question"].exists)
        XCTAssertTrue(app.staticTexts["Correct answer"].exists)
        XCTAssertTrue(app.staticTexts["Offered answers"].exists)
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let element = element2.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        XCTAssertTrue(element.children(matching: .textView).element(boundBy: 1).exists)
        XCTAssertTrue(element.children(matching: .textField).element(boundBy: 1).exists)
        XCTAssertTrue(element.children(matching: .textView).element(boundBy: 0).exists)
        XCTAssertTrue(element.children(matching: .textView).element(boundBy: 0).exists)
        element2.swipeLeft()
    }
    
    func secondScreen(){
        XCTAssertTrue(app.buttons["Logout"].exists)
        XCTAssertTrue(app.staticTexts["Please enter user data"].exists)
        XCTAssertTrue(app.staticTexts["Username"].exists)
        XCTAssertTrue(app.staticTexts["Password"].exists)
        XCTAssertTrue(app.staticTexts["E - mail"].exists)
        XCTAssertTrue(app.buttons["Add user"].exists)
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()

    }
    
    func thirdScreen(){
        
        XCTAssertTrue(app.staticTexts["Enter username and password"].exists)
        XCTAssertTrue(app.staticTexts["Username"].exists)
        XCTAssertTrue(app.staticTexts["Password"].exists)
        XCTAssertTrue(app.buttons["Logout"].exists)
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let element2 = element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        XCTAssertTrue(element2.children(matching: .textField).element(boundBy: 1).exists)
        XCTAssertTrue(element2.children(matching: .textField).element(boundBy: 0).exists)
        XCTAssertTrue(app.staticTexts["0"].exists)
        XCTAssertTrue(app.buttons["Score"].exists)
        app.buttons["Score"].tap()
        let okButton = app.alerts["Wrong data "].collectionViews.buttons["OK"]
        XCTAssertTrue(app.alerts["Wrong data "].exists)
        XCTAssertTrue(okButton.exists)
        
    }
    
    func testLoginAsAdmin(){
    
        app.buttons["Login"].tap()
        app.buttons["Login As Admin"].tap()
        
        self.firstScreen()
       
        self.secondScreen()
        
        self.thirdScreen()
        
    }
    
    func testNavigationLeftAtLoginAsAdmin(){
        
        app.buttons["Login"].tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        app.buttons["Login As Admin"].tap()
        
        let element2 = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element2.swipeLeft()
        element2.swipeLeft()
        element2.swipeLeft()
        firstScreen()
        
    }
 
    func testNavigationRightAtLoginAsAdmin(){
        
        app.buttons["Login"].tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        app.buttons["Login As Admin"].tap()
        
        let element2 = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element2.swipeRight()
        element2.swipeRight()
        element2.swipeRight()
        firstScreen()
    }

    
    func testLogoutFromLoginAsAdmin(){
        
        let window = app.children(matching: .window).element(boundBy: 0)

        app.buttons["Login"].tap()
        app.buttons["Login As Admin"].tap()
        self.firstScreen()
        app.buttons["Logout"].tap()
        self.loginOrRegistersFunc()
        
        app.buttons["Login"].tap()
        app.buttons["Login As Admin"].tap()
        window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeLeft()
        self.secondScreen()
        app.buttons["Logout"].tap()
        self.loginOrRegistersFunc()
        
        app.buttons["Login"].tap()
        app.buttons["Login As Admin"].tap()
        window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeLeft()
        window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeLeft()
        self.thirdScreen()
        app.buttons["Logout"].tap()
        self.loginOrRegistersFunc()
        
    }
    
    func testUserScreen(){
        
        let app = XCUIApplication()
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let element = window.children(matching: .other).element.children(matching: .other).element
        element.tap()
        element.children(matching: .textField).element(boundBy: 0).tap()
        element.children(matching: .textField).element(boundBy: 0)
        
        let textField = element.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.tap()
        element.children(matching: .textField).element(boundBy: 1)
        loginButton.tap()
        
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.staticTexts["dunav"].exists)
        XCTAssertTrue(tablesQuery.staticTexts[" sava"].exists)
        XCTAssertTrue(tablesQuery.staticTexts[" velika morava"].exists)
        XCTAssertTrue(tablesQuery.cells.containing(.staticText, identifier:"dunav").children(matching: .button).matching(identifier: "ic check box outline blank").element(boundBy: 2).exists)
        
        let dunavCellsQuery = tablesQuery.cells.containing(.staticText, identifier:"dunav")
        XCTAssertTrue(dunavCellsQuery.children(matching: .button).matching(identifier: "ic check box outline blank").element(boundBy: 1).exists)
        XCTAssertTrue(tablesQuery.buttons["ic check box outline blank"].exists)
        XCTAssertTrue(tablesQuery.cells.containing(.staticText, identifier:"dunav").children(matching: .button).matching(identifier: "ic check box").element(boundBy: 0).exists)
        XCTAssertTrue(dunavCellsQuery.children(matching: .button).matching(identifier: "ic check box").element(boundBy: 0).exists)
        XCTAssertTrue(tablesQuery.buttons["ic check box"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["wwii"].exists)
        
        let octoberPickerWheel = tablesQuery.pickerWheels["October"]
        octoberPickerWheel.tap()
        octoberPickerWheel.tap()
        XCTAssertTrue(tablesQuery.pickerWheels["3"].exists)
        XCTAssertTrue(tablesQuery.pickerWheels["November"].exists)
        XCTAssertTrue(tablesQuery.pickerWheels["2016"].exists)
        XCTAssertTrue(tablesQuery.staticTexts["glavni grad"].exists)
        
        let glavniGradCellsQuery = tablesQuery.cells.containing(.staticText, identifier:"glavni grad")
        XCTAssertTrue(glavniGradCellsQuery.children(matching: .textField).element.exists)
        XCTAssertTrue(glavniGradCellsQuery.children(matching: .textField).element.exists)
        tablesQuery.buttons["Logout"].tap()
        
        let loginOrRegisterStaticText = app.staticTexts["Login or Register"]
        XCTAssertTrue(loginOrRegisterStaticText.exists)
        loginButton.tap()
        
        let element2 = window.children(matching: .other).element(boundBy: 3).children(matching: .other).element
        XCTAssertTrue(element2.children(matching: .textField).element(boundBy: 0).exists)
        
        let textField2 = element2.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        XCTAssertTrue(element2.children(matching: .textField).element(boundBy: 1).exists)
        loginButton.tap()
        
        let finishButton = tablesQuery.buttons["Finish"]
        finishButton.tap()
        XCTAssertTrue(app.staticTexts["Your score is: "].exists)
        XCTAssertTrue(app.staticTexts["0"].exists)
        XCTAssertTrue(app.buttons["Try Again"].exists)
        finishButton.tap()
        XCTAssertTrue(app.buttons["Logout"].exists)
        XCTAssertTrue(loginOrRegisterStaticText.exists)
        
    }
}
