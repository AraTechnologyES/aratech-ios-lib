//
//  UtilsTests.swift
//  UtilsTests
//
//  Created by Aratech iOS on 31/10/16.
//  Copyright © 2016 AraTech. All rights reserved.
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
