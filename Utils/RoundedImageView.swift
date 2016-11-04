//
//  RoundedImageView.swift
//  Utils

import UIKit

/// Inteface Builder designable `ImageView` with custom corner radius
@IBDesignable public class RoundedImageView: UIImageView {
    
    /// If you want the `ImageView` circular, like profile image
    @IBInspectable public var circular: Bool = false {
        didSet {
            if circular {
                self.layer.cornerRadius = self.frame.size.height / 2
                self.layer.masksToBounds = true
            }
        }
    }
    
    /// Custom corner radius, only if not circular
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            if !circular {
                self.layer.cornerRadius = cornerRadius
                self.layer.masksToBounds = true
            }
        }
    }
}
