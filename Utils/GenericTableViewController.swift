//
//  GenericTableViewController.swift
//  GenericTableView
//
//  Created by Nicolas Landa on 13/6/17.
//  Copyright © 2017 Nicolas Landa. All rights reserved.
//

import UIKit

open class GenericTableViewController<T, Cell: UITableViewCell>: UITableViewController where Cell: Configurable {
	
	public var viewModel: [T] = [] {
		didSet {
			tableView?.reloadData()
		}
	}
	
	override open func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.estimatedRowHeight = tableView.rowHeight
		tableView.rowHeight = UITableViewAutomaticDimension
    }
	
	public init() { super.init(nibName: "GenericTableViewController", bundle: nil) }
	required public init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
	
	override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.count
	}
	
	override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as Cell
		cell.configure(with: self.viewModel[indexPath.row])
		return cell
	}
}
