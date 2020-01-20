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

	/// Establece el título del `UINavigationItem`.
	///
	/// Si el ancho no es suficiente amplía a 2 lineas (máximo), a partir de ahí reduce el tamaño.
	///
	/// - Parameters:
	///   - title: Título
	///   - font: Fuente, `UIFont.systemFont(ofSize: 17, weight: .semibold)` por defecto.
	///   - color: Color del texto
	public func setTitle(
		_ title: String?,
		font: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold),
		color: UIColor) {

		guard let title = title else { return }
		let titleLabel = UILabel(frame: titleView?.frame ?? CGRect(x: 0, y: 0, width: 150, height: 44))
		titleLabel.minimumScaleFactor = 0.25
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.numberOfLines = 2
		titleLabel.lineBreakMode = .byClipping
		titleLabel.font = font
		titleLabel.textColor = .white
		titleLabel.text = title
		titleLabel.textAlignment = .center
		titleLabel.sizeToFit()
		titleView = titleLabel
	}
}
