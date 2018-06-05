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
	
	// MARK: - Enum
	
	struct NetworkError: Error {
		var localizedDescription: String {
			return String(describing: self)
		}
	}
	
	typealias NetworkResult = Result<String>
	
	func testErrorEnum() {
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
	
	// MARK: - Typealias
	
	func asynchronousCallThatThrows(completion: ThrowableCompletion<String>) {
		completion({ throw NetworkError() })
	}
	
	func asynchronousCallThatSucceed(completion: ThrowableCompletion<String>) {
		completion({ return "Success" })
	}
	
	func testThrowableCompletionThatThrows() {
		let throwableExpectation = expectation(description: "testThrowableCompletionThatThrows")
		
		asynchronousCallThatThrows { (result) in
			do {
				let _ = try result()
				XCTAssert(false)
			} catch {
				throwableExpectation.fulfill()
			}
		}
		
		waitForExpectations(timeout: 2.0, handler: nil)
	}
	
	func testThrowableCompletionThatSucceed() {
		let throwableExpectation = expectation(description: "testThrowableCompletionThatSucceed")
		
		asynchronousCallThatSucceed { (result) in
			do {
				let _ = try result()
				throwableExpectation.fulfill()
			} catch {
				XCTAssert(false)
			}
		}
		
		waitForExpectations(timeout: 2.0, handler: nil)
	}
}
