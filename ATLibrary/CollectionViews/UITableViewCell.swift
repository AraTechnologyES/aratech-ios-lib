//
//  UITableViewCell.swift
//  ATLibrary

import Foundation

extension UITableViewCell: NibCounterpartView { }

extension UITableViewCell: ReusableView { }

public extension Registrable where Self: UITableViewCell {
	static func register(in tableView: UITableView) {
		tableView.register(Self.self)
	}
}
