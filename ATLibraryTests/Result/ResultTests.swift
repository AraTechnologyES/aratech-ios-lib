//
//  ResultTests.swift
//  ATLibraryTests
//
//  Created by Nicolás Landa on 17/4/18.
//  
//

import XCTest
@testable import ATLibrary
class ResultTests: XCTestCase {
	
	struct NetworkError: Error {
		var localizedDescription: String {
			return String(describing: self)
		}
	}
	
	typealias NetworkResult = Result<String>
	
	func testAlias() {
		let goodNetworkResult: NetworkResult = .success("All good")
		let badNetworkResult: NetworkResult = .error(NetworkError())
		
		if case .success(let message) = goodNetworkResult {
			XCTAssert(message == "All good")
		} else {
			XCTAssert(false)
		}
		
		if case .error(let error) = badNetworkResult {
			do {
				throw error
			} catch is NetworkError {
				XCTAssert(true)
			} catch {
				XCTAssert(false)
			}
		}
	}
}
