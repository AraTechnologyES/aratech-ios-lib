//
//  SelectableListTests.swift
//  Utils
//
//  Created by Aratech iOS on 2/11/16.
//  Copyright © 2016 AraTech. All rights reserved.
//

import XCTest

@testable import Utils
class SelectableListTests: XCTestCase {
    
    var zones = SelectableList()
    
    func testSelectableList() {
        
        let zone1 = zones[0]
        let zone1Categories = zones.childList(forIndex: 0)!
        _ = zone1Categories[0]
        
        XCTAssert(zone1.state == .noSelected)
        
        let _ = zone1Categories.listElement(wasSelectedAt: 0) // Category1 -> Selected
        
        XCTAssert(zone1.state == .partial) // Zone1 tiene que estar parcialmente seleccionado
        
        let _ = zone1Categories.listElement(wasSelectedAt: 1) // Category2 -> Selected
        
        XCTAssert(zone1.state == .selected) // Zone1 tiene que estar seleccionado
        
        let category1Subcategories = zone1Categories.childList(forIndex: 0)
        
        let subcategory1 = category1Subcategories![0]
        
        let subcategory2 = category1Subcategories![1]
        
        XCTAssert(subcategory1.state == .selected) // subcategory1 tiene que estar seleccionado
        
        XCTAssert(subcategory2.state == .selected) // subcategory2 tiene que estar seleccionado
        
        let _ = zone1Categories.listElement(wasSelectedAt: 1) // Category2 -> noSelected
        
        XCTAssert(zone1.state == .partial) // Zone1 tiene que estar parcialmente seleccionado
        
        let _ = zone1Categories.listElement(wasSelectedAt: 0) // Category1 -> noSelected
        
        XCTAssert(zone1.state == .noSelected) // Zone1 tiene que estar no seleccionado
        
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
