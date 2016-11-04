//
//  RoundedImageView.swift
//  Utils

import UIKit

/// Inteface Builder designable `ImageView` with custom corner radius
@IBDesignable class RoundedImageView: UIImageView {
    
    /// If you want the `ImageView` circular, like profile image
    @IBInspectable var circular: Bool = false {
        didSet {
            if circular {
                self.layer.cornerRadius = self.frame.size.height / 2
                self.layer.masksToBounds = true
            }
        }
    }
    
    /// Custom corner radius, only if not circular
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            if !circular {
                self.layer.cornerRadius = cornerRadius
                self.layer.masksToBounds = true
            }
        }
    }
}
