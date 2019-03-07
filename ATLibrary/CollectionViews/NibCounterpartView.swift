//
//  NibLoadableView.swift
//  ATLibrary

import Foundation

// MARK:- NibLoadableView

public protocol NibCounterpartView: class {}

public extension NibCounterpartView where Self: UIView {
    
    public static var nibName: String {
        return String(describing: self)
    }
}
