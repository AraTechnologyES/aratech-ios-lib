//
//  NibLoadableView.swift
//  Utils

import Foundation

// MARK:- NibLoadableView

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
}
