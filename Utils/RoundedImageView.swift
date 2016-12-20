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
                self.layer.borderWidth = 1.0
                self.layer.borderColor = UIColor.lightGray.cgColor
                self.layer.cornerRadius = self.bounds.width / 2
                self.clipsToBounds = true
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
