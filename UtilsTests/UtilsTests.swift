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
        let button = StyleableButton(type: .system)
        button.apply(style: .default)
        XCTAssert(button.contentEdgeInsets.top==10.0 && button.contentEdgeInsets.left == 20.0 && button.contentEdgeInsets.bottom == 10.0 && button.contentEdgeInsets.right == 20.0)
        XCTAssert(button.titleColor(for: .selected) == .white && button.titleColor(for: .normal) == .black)
        
        let textField = StyleableTextField(frame: CGRect.zero)
        textField.apply(style: .default)
        XCTAssert(textField.textColor == .white)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
