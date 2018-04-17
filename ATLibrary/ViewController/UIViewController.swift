//
//  UIViewController.swift
//  ATLibrary

import Foundation
import UIKit

//MARK:- UIViewController

public extension UIViewController {
    public var content: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController!
        } else {
            return self
        }
    }
}
