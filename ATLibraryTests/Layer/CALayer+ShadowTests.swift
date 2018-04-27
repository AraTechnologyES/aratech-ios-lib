//
//  CALayer+ShadowTests.swift
//  ATLibraryTests
//
//  Created by Nicolás Landa on 27/4/18.
//  
//

import XCTest
@testable import ATLibrary

extension CALayer.ShadowConfiguration {
	static let testWithSpread = CALayer.ShadowConfiguration(color: .lightGray,
												  x: 2, y: 4,
												  blur: 5.0, spread: 3.0)
	
	static let testWithOutSpread = CALayer.ShadowConfiguration(color: .lightGray,
															x: 2, y: 4,
															blur: 5.0, spread: 0.0)
}

class CALayer_ShadowTests: XCTestCase {
	
    func testLayerHasShadowPropertiesAfterCallingShadowMethod() {
		let frame = CGRect(x: 0, y: 0, width: 35, height: 35)
		let spread: CGFloat = 3.0

		let layer = CALayer()
		layer.frame = frame

		let rectForSpread = layer.bounds.insetBy(dx: -spread, dy: -spread)
		let shadowcgPath = UIBezierPath(rect: rectForSpread).cgPath

		layer.shadow(.testWithSpread)

		XCTAssert(layer.shadowColor == UIColor.lightGray.cgColor)
		XCTAssert(layer.shadowOpacity == 1)
		XCTAssert(layer.shadowOffset == CGSize(width: 2, height: 4))
		XCTAssert(layer.shadowRadius == 5.0 / 2.0)
		XCTAssert(layer.shadowPath == shadowcgPath)

		layer.shadow(.testWithOutSpread)
		XCTAssertNil(layer.shadowPath)
    }
}
