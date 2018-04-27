//
//  CALayer+ShadowTests.swift
//  ATLibraryTests
//
//  Created by Nicolás Landa on 27/4/18.
//  
//

import XCTest

class CALayer_ShadowTests: XCTestCase {
	
    func testLayerHasShadowPropertiesAfterCallingShadowMethod() {
		let frame = CGRect(x: 0, y: 0, width: 35, height: 35)
		let spread: CGFloat = 3.0
		
		let layer = CALayer()
		layer.frame = frame
		
		let rectForSpread = layer.bounds.insetBy(dx: -spread, dy: -spread)
		let shadowcgPath = UIBezierPath(rect: rectForSpread).cgPath
		
		layer.shadow(color: .lightGray, x: 2, y: 4, blur: 5.0, spread: spread)
		
		XCTAssert(layer.shadowColor == UIColor.lightGray.cgColor)
		XCTAssert(layer.shadowOpacity == 1)
		XCTAssert(layer.shadowOffset == CGSize(width: 2, height: 4))
		XCTAssert(layer.shadowRadius == 5.0 / 2.0)
		XCTAssert(layer.shadowPath == shadowcgPath)
		
		layer.shadow(color: .lightGray, x: 0, y: 0, blur: 0, spread: 0)
		XCTAssertNil(layer.shadowPath)
    } 
}
