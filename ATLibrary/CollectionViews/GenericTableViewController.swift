//
//  GenericTableViewController.swift
//  GenericTableView
//
//  Created by Nicolas Landa on 13/6/17.
//  
//

import UIKit

open class GenericTableViewController<T, Cell: UITableViewCell>: UITableViewController where Cell: Configurable, Cell.Model == T {
		
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
		
		let model: Cell.Model = self.viewModel[indexPath.row]
		cell.configure(with: model)
		
		return cell
	}
}
