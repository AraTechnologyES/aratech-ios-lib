//
//  ReusableView.swift
//  Utils

import Foundation

// MARK:- ReusableView

protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
