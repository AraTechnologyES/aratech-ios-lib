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
	@available(*, deprecated, message: "Use add(to:style:size) instead")
	public class func loadingIndicator(in view: UIView) -> UIActivityIndicatorView {
		let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
		activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		activityIndicator.center = CGPoint(x: view.bounds.size.width / 2,
										   y: view.bounds.size.height / 2)
		activityIndicator.hidesWhenStopped = true
		return activityIndicator
	}

	class func add(to view: UIView, style: UIActivityIndicatorView.Style = .white, size: CGSize? = nil) -> UIActivityIndicatorView {
		let activityIndicator = UIActivityIndicatorView(style: style)

		if let size = size {
			activityIndicator.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		}

		activityIndicator.center = CGPoint(x: view.bounds.size.width / 2,
																			 y: view.bounds.size.height / 2)

		activityIndicator.hidesWhenStopped = true
		view.insertSubview(activityIndicator, at: 0)

		return activityIndicator
	}
}
