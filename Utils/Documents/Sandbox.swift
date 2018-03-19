//
//  Sandbox.swift
//  Utils


import Foundation

// MARK:- Sandbox
public struct Sandbox {
    /// Document's directory of app
    public static let Documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    public static let Library = try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
	
	public struct ApplicationSupport {
		public static var root: URL {
			let appBundleID = Bundle.main.bundleIdentifier!
			return try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(appBundleID, isDirectory: true)
		}
	}
}
