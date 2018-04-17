//
//  RoundedImageView.swift
//  ATLibrary

import UIKit

/// Inteface Builder designable `ImageView` with custom corner radius
@IBDesignable public class RoundedImageView: UIImageView {
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		
		self.clipsToBounds = true
		self.layer.masksToBounds = true
	}
	
	/// If you want the `ImageView` circular, like profile image
	@IBInspectable public var circular: Bool = false {
		didSet {
			if circular {
				self.layer.borderWidth = 1.0
				self.layer.borderColor = UIColor.lightGray.cgColor
				self.layer.cornerRadius = self.bounds.width / 2
			}
		}
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		// Custom
		
		if circular {
			self.layer.cornerRadius = self.bounds.width / 2
			
		} else {
			self.layer.cornerRadius = cornerRadius
		}
		
		self.layer.borderWidth = self.borderWidth
		self.layer.borderColor = self.borderColor?.cgColor
	}
}
