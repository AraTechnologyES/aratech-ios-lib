//
//  TestAppUITests.swift
//  TestAppUITests
//
//  Created by Aratech iOS on 16/2/17.
//  Copyright © 2017 AraTech. All rights reserved.
//

import XCTest
import Utils

class TestAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStyleAccesibility() {
        
//        let button = UIButton(type: .system)
//        button.apply(style: .default)
//        XCTAssert(button.contentEdgeInsets.top==5.0 && button.contentEdgeInsets.left == 20.0 && button.contentEdgeInsets.bottom == 5 && button.contentEdgeInsets.right == 20.0)
//        
//        let textField = UITextField(frame: CGRect.zero)
//        textField.apply(style: .default)
//        XCTAssert(textField.textColor == .white)
    }
}
