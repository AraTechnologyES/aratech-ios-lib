//
//  ActivityIndicator+Loading.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 23/8/18.
//  
//

public extension UIActivityIndicatorView {
	
	/// Indicador de carga, centrado y de (40, 40)
	///
	/// - Parameter view: Vista en la que centrar el indicador, éste NO se añade a la vista.
	/// - Returns: El indicador de carga
	public class func loadingIndicator(in view: UIView) -> UIActivityIndicatorView {
		let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
		activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		activityIndicator.center = CGPoint(x: view.bounds.size.width / 2,
										   y: view.bounds.size.height / 2)
		activityIndicator.hidesWhenStopped = true
		return activityIndicator
	}
}
