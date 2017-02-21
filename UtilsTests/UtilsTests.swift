//
//  UtilsTests.swift
//  UtilsTests
//

import XCTest
@testable import Utils

class UtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUIColorExtension() {
        let hexColor = UIColor(hex: "#949599")
        let rgbColor = UIColor(red: 148.0/255.0, green: 149.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        
        XCTAssert(hexColor!==rgbColor)
    }
    
    func testStyle() {
        let button = UIButton(type: .system)
        button.apply(style: .login)
        XCTAssert(button.contentEdgeInsets.top==5.0 && button.contentEdgeInsets.left == 20.0 && button.contentEdgeInsets.bottom == 5 && button.contentEdgeInsets.right == 20.0)
        
        let textField = UITextField(frame: CGRect.zero)
        textField.apply(style: .login)
        XCTAssert(textField.textColor == .white)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
