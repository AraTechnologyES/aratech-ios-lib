//
//  Identifiable.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 3/9/18.
//  
//  https://www.swiftbysundell.com/posts/type-safe-identifiers-in-swift

import Foundation

/**

  Protocolo a adoptar para aquellos que deseen ser *identificables*

  ```
  struct User: Identifiable {
    let id: Identifier<User>

  }
  ```
*/
public protocol Identifiable {
	associatedtype RawIdentifier: Codable = String
	
	var id: Identifier<Self> { get }
}

/// Identificador a usar para un determinado *Identifiable*
public struct Identifier<Value: Identifiable> {
	let rawValue: Value.RawIdentifier
	
	init(rawValue: Value.RawIdentifier) {
		self.rawValue = rawValue
	}
}

extension Identifier: CustomStringConvertible where Value.RawIdentifier == String {
	public var description: String {
		return rawValue
	}
}



