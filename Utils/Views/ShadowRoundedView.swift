//
//  ShadowRoundedView.swift
//  Utils

import UIKit

@IBDesignable
class ShadowRoundedView: UIView {
	
	@IBInspectable override var cornerRadius: CGFloat {
		get {
			return self.contentView.layer.cornerRadius
		}
		set {
			self.contentView.layer.cornerRadius = newValue
		}
	}
	
	@IBInspectable override var borderWidth: CGFloat {
		get {
			return self.contentView.layer.borderWidth
		}
		set {
			self.contentView.layer.borderWidth = newValue
		}
	}
	
	@IBInspectable override var borderColor: UIColor? {
		get {
			if let color = self.contentView.layer.borderColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue {
				self.contentView.layer.borderColor = color.cgColor
			} else {
				self.contentView.layer.borderColor = nil
			}
		}
	}
	
	@IBInspectable override var shadowRadius: CGFloat {
		get {
			return self.shadowView.layer.shadowRadius
		}
		set {
			self.shadowView.layer.shadowRadius = newValue
		}
	}
	
	@IBInspectable override var shadowOpacity: Float {
		get {
			return self.shadowView.layer.shadowOpacity
		}
		set {
			self.shadowView.layer.shadowOpacity = newValue
		}
	}
	
	@IBInspectable override var shadowOffset: CGSize {
		get {
			return self.shadowView.layer.shadowOffset
		}
		set {
			self.shadowView.layer.shadowOffset = newValue
		}
	}
	
	@IBInspectable override var shadowColor: UIColor? {
		get {
			if let color = self.shadowView.layer.shadowColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue {
				self.shadowView.layer.shadowColor = color.cgColor
			} else {
				self.shadowView.layer.shadowColor = nil
			}
		}
	}

	@IBInspectable var contentBackgroundColor: UIColor? {
		get {
			return self.contentView.backgroundColor
		} set {
			self.contentView.backgroundColor = newValue
		}
	}
	
	var shadowView: UIView!
	var contentView: UIView!
	
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
		
		self.contentView = UIView(frame: self.bounds)
		contentView.backgroundColor = self.contentBackgroundColor ?? .white
		contentView.clipsToBounds = true
		
		shadowView.addSubview(contentView)
		self.addSubview(shadowView)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.shadowView.frame = self.bounds
		self.contentView.frame = self.bounds
		
		for subview in subviews {
			if subview != shadowView && subview != contentView {
				self.bringSubview(toFront: subview)
			}
		}
	}
}
