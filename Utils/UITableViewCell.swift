//
//  UITableViewCell.swift
//  Utils

import Foundation

extension UITableViewCell: NibLoadableView { }

extension UITableViewCell: ReusableView { }

/// Protocolo que define la función configurar. Su uso está orientado a tablas y colecciones.
public protocol Configurable {
	
	associatedtype Model
	
	/// Configura al objeto implementador
	///
	/// - Parameter model: Modelo con el que configurar el objeto implementador
	func configure(with model: Model)
}

/// Protocolo que define la función registrar. Su uso está orientado a tablas y colecciones.
public protocol Registrable {
	/// Registra el objeto implementador en la colección
	///
	/// - Parameter collectionView: Colección en la que registrar al objeto implementador
	static func register(in collectionView: UICollectionView)
	
	/// Registra el objeto implementador en la tabla
	///
	/// - Parameter tableView: Tabla en la que registrar al objeto implementador
	static func register(in tableView: UITableView)
}

public extension Registrable where Self: UITableViewCell {
	static func register(in tableView: UITableView) {
		tableView.register(Self.self)
	}
}
