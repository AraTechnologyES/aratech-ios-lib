//
//  UITableViewCell.swift
//  ATLibrary

import Foundation

extension UITableViewCell: NibLoadableView { }

extension UITableViewCell: ReusableView { }

public extension Registrable where Self: UITableViewCell {
	static func register(in tableView: UITableView) {
		tableView.register(Self.self)
	}
}
