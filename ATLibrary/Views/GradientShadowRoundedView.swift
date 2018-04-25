//
//  GradientShadowRoundedView.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 25/4/18.
//  
//

@IBDesignable
class GradientShadowRoundedView: ShadowRoundedView {
	
	@IBInspectable public var startPoint: CGPoint {
		get {
			return self.gradient.startPoint
		}
		set {
			self.gradient.startPoint = newValue
		}
	}
	
	@IBInspectable public var endPoint: CGPoint {
		get {
			return self.gradient.endPoint
		}
		set {
			self.gradient.endPoint = newValue
		}
	}
	
	public var colors: [CGColor]? {
		get {
			return self.gradient.colors as? [CGColor]
		}
		set {
			self.gradient.colors = newValue
		}
	}
	
	private(set) public var gradient: CAGradientLayer!
	
	override func setup() {
		super.setup()
		
		// ShadowRoundedView gradient background
		self.gradient = CAGradientLayer()
		self.gradient.startPoint = CGPoint(x: 0, y: 0.5)
		self.gradient.endPoint = CGPoint(x: 1, y: 0.5)
		
		self.contentView.layer.addSublayer(self.gradient)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		// Set gradient layer's frame
		self.gradient.frame = self.contentView.frame
	}
}
