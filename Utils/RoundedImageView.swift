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
	
	/// Border width, `0.0` by default
	@IBInspectable public var borderWidth: CGFloat = 0.0
	/// Border color, `.clear` by default
	@IBInspectable public var borderColor: UIColor = .clear
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		// Custom
		
		if circular {
			self.layer.cornerRadius = self.bounds.width / 2
			
		} else {
			self.layer.cornerRadius = cornerRadius
		}
		
		self.clipsToBounds = true
		self.layer.masksToBounds = true
		
		self.layer.borderWidth = self.borderWidth
		self.layer.borderColor = self.borderColor.cgColor
	}
}
