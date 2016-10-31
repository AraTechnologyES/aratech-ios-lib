//
//  NibLoadableView.swift
//  Utils

import Foundation

// MARK:- NibLoadableView

public protocol NibLoadableView: class {}

public extension NibLoadableView where Self: UIView {
    
    public static var nibName: String {
        return String(describing: self)
    }
}
