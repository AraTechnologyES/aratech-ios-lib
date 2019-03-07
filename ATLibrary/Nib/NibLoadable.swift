//
//  NibLoadable.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 28/11/2018.
//  
//

import UIKit

/// Un objeto que puede ser cargado desde un fichero `.xib`
///
/// La implementación por defecto carga un fichero `.xib` con el nombre de la clase implementadora del protocolo.
///
/// [Credits](https://gist.github.com/joshavant/86df569f054c07921f60)
public protocol NibLoadable {
	
	/// La implementación por defecto carga un fichero `.xib` con el nombre de la clase implementadora del protocolo.
	///
	/// Por ejemplo: `class MyCoolView { ... }`  carga `MyCoolView.xib`
	func setupFromXib()
}

public extension NibLoadable where Self: UIView {
	func setupFromXib() {
		// load the root UIView (i.e. root subview layer of the xib)
		let bundle = Bundle(for: type(of: self))
		let fileName = String(describing: type(of: self))
		let nib = UINib(nibName: fileName, bundle: bundle)
		
		// reminder: instantiating with `owner: self` takes care of hooking up
		// all the IBOutlets from the nib, to this class
		let rootView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
		
		// setup that view's geometry
		rootView.frame = bounds
		rootView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
		
		// add that view to myself
		addSubview(rootView)
	}
}

/// Clase que carga la vista dede el `.xib` por defecto en `commonInit()`.
///
/// Llamar a la implementacion de super si se sobrescribe.
open class NibLoadableView: UIView, NibLoadable {
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	public func commonInit() {
		setupFromXib()
	}
}
