//
//  UIImage+SetAnimated.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 08/01/2019.
//  
//

public extension UIImageView {
	
	public func animated(set image: UIImage?, duration: Double = 0.75) {
		let previousAlpha = self.alpha
		
		self.alpha = 0.0
		self.image = image
		
		UIView.animate(withDuration: duration) {
			self.alpha = previousAlpha
		}
	}
}
