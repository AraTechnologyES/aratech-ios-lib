//
//  LoadResourcesViewController.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 20/11/2018.
//  
//

import os

/// Controlador para la carga de recursos previa al inicio de la app, normalmente tras el Splash inicial.
/// Se deben sobreescribir los métodos `loadResources` y `resourcesLoaded`.
///
/// Incluye un `UIActivityIndicatorView` mientras dure la carga de los distintos recursos.
open class LoadResourcesViewController: UIViewController {
	
	/// Dispatch Group
	private var dispathGroup: DispatchGroup = DispatchGroup()
	
	/// Indicador de actividad
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
		activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2,
										   y: self.view.bounds.size.height / 2)
		activityIndicator.hidesWhenStopped = true
		return activityIndicator
	}()
	
	// MARK: - Life cicle
	
	open override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.view.addSubview(self.activityIndicator)
		self.activityIndicator.startAnimating()
		self.loadResources()
	}
	
	override open func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		dispathGroup.notify(queue: .main) { [unowned self] in
			self.activityIndicator.stopAnimating()
			self.resourcesLoaded()
		}
	}
	
	// MARK: - API
	
	/// Comienza una tarea de carga
	///
	/// Debe complementarse con una llamada a `endLoad` cuando finalize la carga
	public final func beginLoad() {
		if #available(iOS 12.0, *) {
			os_log(.debug, log: .atLibrary, "beginLoad called")
		} else {
			// Fallback on earlier versions
		}
		dispathGroup.enter()
	}
	
	/// Termina una tarea de carga
	public final func endLoad() {
		if #available(iOS 12.0, *) {
			os_log(.debug, log: .atLibrary, "endLoad called")
		} else {
			// Fallback on earlier versions
		}
		dispathGroup.leave()
	}
	
	/// Sobreescribir para cargar los recursos deseados.
	///
	/// Incluir una llamada a `beginLoad` y `endLoad` para cada recurso que se desee cargar.
	/// La implementación por defecto no hace nada
	open func loadResources() { }
	
	/// Sobreescribir para continuar con el flujo de la aplicación
	///
	/// La implementación por defecto no hace nada
	open func resourcesLoaded() { }
	
	// MARK: - Helpers
	
	/// Busca el valor asociado a una clave en el fichero `Info.plist`
	///
	/// - Parameter key: clave
	/// - Returns: El valor asociado a la clave en el fichero `Info.plist`
	public func infoForKey<T>(_ key: String) -> T? {
		return (Bundle.main.infoDictionary?[key] as? T)
	}
}
