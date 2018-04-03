//
//  DictionaryTests.swift
//  UtilsTests

import XCTest
@testable import Utils

class DictionaryTests: XCTestCase {
    
    func testValueForKeyWithDefaultValue() {
		let dictionary: [String: Any] = ["a": 1, "b": 2]
		
		XCTAssert(dictionary.value(forKey: "a", defaultValue: 0) == 1)
		XCTAssert(dictionary.value(forKey: "x", defaultValue: 0) == 0)
    }
}
