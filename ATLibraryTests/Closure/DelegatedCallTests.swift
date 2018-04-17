//
//  DelegatedCallTests.swift
//  ATLibraryTests
//
//  Created by Nicolás Landa on 17/4/18.
//  
//

import XCTest
@testable import ATLibrary
class DelegatedCallTests: XCTestCase {
	
	var didFinish: DelegatedCall<String>!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		
		self.didFinish = DelegatedCall<String>()
    }
	
	func testDelegatedCallInitsEmpty() {
		XCTAssertNil(self.didFinish.callback)
	}
    
    func testDelegatedCallSetsCallback() {
		self.didFinish.delegate(to: self) { (_, _) in
			
		}
		
		XCTAssertNotNil(self.didFinish.callback)
    }
	
	func testDelegatedCallExecutesCallback() {
		var delegatedCallDidExecuteCallback = false
		
		self.didFinish.delegate(to: self) { (_, _) in
			delegatedCallDidExecuteCallback = true
		}
		
		self.didFinish.callback?("")
		
		XCTAssert(delegatedCallDidExecuteCallback)
	}
}
