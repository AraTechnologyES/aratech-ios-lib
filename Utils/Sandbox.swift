//
//  Sandbox.swift
//  Utils


import Foundation

// MARK:- Sandbox
public struct Sandbox {
    /// Document's directory of app
    static let Documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    static let Library = try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
}
