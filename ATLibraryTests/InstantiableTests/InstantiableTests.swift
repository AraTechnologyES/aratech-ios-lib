//
//  InstantiableTests.swift
//  ATLibraryTests
//
//  Created by Aratech iOS on 20/3/18.
//  Copyright © 2018 AraTech. All rights reserved.
//

import XCTest
@testable import ATLibrary
class InstantiableTests: XCTestCase {
    
    func testInstantiableViewControllerInstantiates() {
		do {
			let instantiableViewController: UIViewController = try InstantiableViewController.instantiateFromStoryboard()
			XCTAssert(instantiableViewController is InstantiableViewController)
		} catch {
			XCTAssert(false)
		}
    }
    
    func testInstantiableErrors() {
		do {
			let _ = try NoStoryboardNameViewController.instantiateFromStoryboard()
		} catch let error {
			XCTAssert(error is InstantiationError)
			
			let instantiationError = error as! InstantiationError
			XCTAssert(instantiationError == .noStoryboardName)
			
			do {
				let _ = try NoIdentifierViewController.instantiateFromStoryboard()
			} catch let error {
				XCTAssert(error is InstantiationError)
				
				let noIdentifierError = error as! InstantiationError
				XCTAssert(noIdentifierError == .noViewControllerIdentifier)
			}
		}
    }
    
}

public class InstantiableViewController: UIViewController, Instantiable {
	public static var storyboard: String? { return "Instantiable" }
}

public class NoStoryboardNameViewController: UIViewController, Instantiable { }

public class NoIdentifierViewController: UIViewController, Instantiable {
	public static var storyboard: String? { return "Instantiable" }
	public static var identifier: String? { return nil }
}
