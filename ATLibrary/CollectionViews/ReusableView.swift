//
//  ReusableView.swift
//  ATLibrary

import Foundation

// MARK:- ReusableView

public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
