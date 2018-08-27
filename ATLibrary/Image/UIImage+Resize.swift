//
//  UIImage+Resize.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 27/8/18.
//  
//

public extension UIImage {
	
	/// Redimensiona la imagen en base a una anchura, respeta la relación de aspecto.
	///
	/// - Parameter newWidth: La anchura de la nueva imagen
	/// - Returns: La imagen redimensionada
	public func resize(width newWidth: CGFloat) -> UIImage {
		let scale = newWidth / self.size.width
		let newHeight = self.size.height * scale
		let newSize = CGSize(width: newWidth, height: newHeight)
		
		UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
		self.draw(in: CGRect(origin: .zero, size: newSize))
		let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return resizedImage!
	}
}
