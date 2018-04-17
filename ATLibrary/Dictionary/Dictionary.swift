//
//  Dictionary.swift
//  ATLibrary

import Foundation

// https://www.swiftbysundell.com/posts/using-autoclosure-when-designing-swift-apis
public extension Dictionary where Value == Any {
	func value<T>(forKey key: Key, defaultValue: @autoclosure () -> T) -> T {
		guard let value = self[key] as? T else {
			return defaultValue()
		}
		
		return value
	}
}
