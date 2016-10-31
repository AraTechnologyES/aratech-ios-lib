//
//  UIViewController.swift
//  Utils

import Foundation
import UIKit

//MARK:- UIViewController

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController!
        } else {
            return self
        }
    }
}
