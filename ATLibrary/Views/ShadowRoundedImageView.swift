//
//  ShadowRoundedImageView.swift
//  ATLibrary

import UIKit

@IBDesignable
class ShadowRoundedImageView: UIView {
	
	@IBInspectable var imageBackgroundColor: UIColor? = Color.Gray.dark
	
	@IBInspectable var image: UIImage? {
		get {
			return self.imageView.image
		} set {
			self.imageView.image = newValue
			self.imageView.backgroundColor = newValue != nil ? .clear : self.imageBackgroundColor
		}
	}
	
	var shadowView: UIView!
	var imageView: UIImageView!

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setup()
	}
	
	func setup() {
		
		self.backgroundColor = .clear
		
		self.shadowView = UIView(frame: self.bounds)
		shadowView.clipsToBounds = false
		shadowView.backgroundColor = .clear
		shadowView.layer.shadowOpacity = 0.5
		shadowView.layer.shadowOffset = .zero
		shadowView.layer.shadowRadius = 1.5
		
		self.imageView = UIImageView(frame: self.bounds)
		imageView.contentMode = .scaleAspectFill
		imageView.backgroundColor = self.imageBackgroundColor
		imageView.clipsToBounds = true
		imageView.backgroundColor = Color.Gray.dark
		imageView.layer.cornerRadius = 3
		
		shadowView.addSubview(imageView)
		self.addSubview(shadowView)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.shadowView.frame = self.bounds
		self.imageView.frame = self.bounds
		
		for subview in subviews {
			if subview != shadowView && subview != imageView {
				self.bringSubview(toFront: subview)
			}
		}
	}
}
