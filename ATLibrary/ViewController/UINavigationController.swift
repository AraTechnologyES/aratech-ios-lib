//
//  UINavigationController.swift
//  ATLibrary

import Foundation

//MARK:- UINavigationController

public extension UINavigationController {
    
    public func presentTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        setNavigationBarHidden(false, animated:true)
    }
    
    public func hideTransparentNavigationBar() {
        setNavigationBarHidden(true, animated:false)
        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
        navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
        navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    }
}

public extension UINavigationItem {
	
	/// Establece el título del botón de atrás
	///
	/// - Parameter title: Título del botón de atrás
	func setBackButtonItemTitle(_ title: String?) {
		guard let title = title else { return }
		self.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
	}
}
