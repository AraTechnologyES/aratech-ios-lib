//
//  LoggerTests.swift
//  ATLibraryTests
//
//  Created by Aratech iOS on 20/3/18.
//  Copyright © 2018 AraTech. All rights reserved.
//

import XCTest
@testable import ATLibrary
class LoggerTests: XCTestCase {
    
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testShouldWrite() {
		let debugLogger = Logger(withLevel: .debug)
		let infoLogger = Logger(withLevel: .info)
		let noticeLogger = Logger(withLevel: .notice)
		let warningLogger = Logger(withLevel: .warning)
		let errorLogger = Logger(withLevel: .error)
		let releaseLogger = Logger(withLevel: .error, mode: .release, showLevel: false, showFileNames: false, showLineNumbers: false)
		
		debugLogger.debug("")
		infoLogger.info("")
		noticeLogger.notice("")
		warningLogger.warning("")
		errorLogger.error("")
		
		releaseLogger.log("")
		
		XCTAssert(infoLogger.shouldWrite(inSeverityLevel: .info, evenInReleaseMode: false))
		
		XCTAssert(!infoLogger.shouldWrite(inSeverityLevel: .debug, evenInReleaseMode: false))
		
		XCTAssert(!releaseLogger.shouldWrite(inSeverityLevel: .error, evenInReleaseMode: false))
		
		XCTAssert(releaseLogger.shouldWrite(inSeverityLevel: .error, evenInReleaseMode: true))
	}
	
	func testWriteFormat() {
		let infoLogger = Logger(withLevel: .info)
		
		infoLogger.info("testWriteFormat")
		var output = infoLogger.formatOutput(text: "testWriteFormat", sourceFile: "ATLoggerTests.swift", functionName: "testWriteFormat", lineNumber: 40)
		
		let range = output.startIndex..<output.index(output.startIndex, offsetBy: 20)
		output.removeSubrange(range) // Quitar la fecha
		let testOutput = "[INFO] [testWriteFormat] [ATLoggerTests.swift:40]| testWriteFormat"
		
		XCTAssert(testOutput == output)
	}
}
