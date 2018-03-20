//
//  Instantiable.swift
//  Utils
//
//  Created by Alejandro Jiménez Agudo on 22/8/16.
//  Modified by Nicolas Landa on 20/3/18.
//

import Foundation

/// Error al instanciar
///
/// - noStoryboardIdentifier: No se especifica un nombre de Storyboard
/// - noViewControllerIdentifier: No se especifica el identificador del controlador en el Storyboard
/// - downcastingError: Error al castear desde UIViewController
public enum InstantiationError: Error {
	/// No se especifica un nombre de Storyboard
	case noStoryboardName
	/// No se especifica el identificador del controlador en el Storyboard
	case noViewControllerIdentifier
	/// Error al castear desde UIViewController
	case downcastingError
}

public protocol Instantiable {
	/// Bundle en el que se encuentra el Storyboard
	static var bundle: Bundle { get }
	/// Nombre del Storyboard al que pertenece el controlador
	static var storyboard: String? { get }
	/// Identificador del controlador en el Storyboard
	static var identifier: String? { get }
}

public extension Instantiable where Self: UIViewController {
	/// Bundle en el que se encuentra el Storyboard
	static var bundle: Bundle { return Bundle(for: Self.self) }
	/// Nombre del Storyboard al que pertenece el controlador
	static var storyboard: String? { return nil }
	/// Identificador del controlador en el Storyboard
	static var identifier: String? { return String(describing: Self.self) }
}

public extension Instantiable {
	
	/**

	Instancia el controlador desde el Storyboard.
	
	- Returns: El controlador ya casteado
	- Throws: InstantiationError
	*/
	public static func instantiateFromStoryboard() throws -> Self {
		guard let storyboardName = Self.storyboard else { throw InstantiationError.noStoryboardName }
		guard let viewControllerIdentifier = Self.identifier else { throw InstantiationError.noViewControllerIdentifier }
		
		let bundle = Self.bundle
		let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
		
		let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
		
		if let downcastedViewController = viewController as? Self {
			return downcastedViewController
		} else {
			throw InstantiationError.downcastingError
		}
	}
}
