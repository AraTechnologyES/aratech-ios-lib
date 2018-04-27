//
//  CALayer+Shadow.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 27/4/18.
//  https://github.com/artemnovichkov/zepcode/blob/master/.github/CALayer+Shadow.swift
//

public extension CALayer {
	
	/// Aplica sombra a la capa en función de los parámetros normalmente presentes en los programas de diseño.
	///
	/// - Parameters:
	///   - color: Color de la sombra
	///   - x: Offset en el eje x
	///   - y: Offset en el eje y
	///   - blur: Cantidad de sombra
	///   - spread: Extensión de la sombra
	public func shadow(color: UIColor,
					   x: CGFloat = 0,
					   y: CGFloat = 0,
					   blur: CGFloat = 0,
					   spread: CGFloat = 0) {
		
		self.shadowColor = color.cgColor
		self.shadowOpacity = 1
		self.shadowOffset = CGSize(width: x, height: y)
		self.shadowRadius = blur / 2
		if spread == 0 {
			self.shadowPath = nil
		} else {
			let rect = self.bounds.insetBy(dx: -spread, dy: -spread)
			self.shadowPath = UIBezierPath(rect: rect).cgPath
		}
	}
}
