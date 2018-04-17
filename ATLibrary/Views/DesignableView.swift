//
//  DesignableView.swift
//  Utils

import UIKit

@IBDesignable class DesignableView: UIView { }
@IBDesignable class DesignableButton: UIButton { }
@IBDesignable class DesignableLabel: UILabel { }

extension UIView {

	@IBInspectable var cornerRadius: CGFloat {
		get {
			return self.layer.cornerRadius
		}
		set {
			self.layer.cornerRadius = newValue
		}
	}
	
	@IBInspectable var borderWidth: CGFloat {
		get {
			return self.layer.borderWidth
		}
		set {
			self.layer.borderWidth = newValue
		}
	}
	
	@IBInspectable var borderColor: UIColor? {
		get {
			if let color = self.layer.borderColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue {
				self.layer.borderColor = color.cgColor
			} else {
				self.layer.borderColor = nil
			}
		}
	}
	
	@IBInspectable var shadowRadius: CGFloat {
		get {
			return self.layer.shadowRadius
		}
		set {
			self.layer.shadowRadius = newValue
		}
	}
	
	@IBInspectable var shadowOpacity: Float {
		get {
			return self.layer.shadowOpacity
		}
		set {
			self.layer.shadowOpacity = newValue
		}
	}
	
	@IBInspectable var shadowOffset: CGSize {
		get {
			return self.layer.shadowOffset
		}
		set {
			self.layer.shadowOffset = newValue
		}
	}
	
	@IBInspectable var shadowColor: UIColor? {
		get {
			if let color = self.layer.shadowColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
		set {
			if let color = newValue {
				self.layer.shadowColor = color.cgColor
			} else {
				self.layer.shadowColor = nil
			}
		}
	}
}
