//
//  GenericTableViewController.swift
//  GenericTableView
//
//  Created by Nicolas Landa on 13/6/17.
//  Copyright © 2017 Nicolas Landa. All rights reserved.
//

import UIKit

protocol Configurable {
	var viewModel: Any?
}

class GenericTableViewController<T, Cell: Configurable>: UITableViewController {
	
	var viewModel: [T] = [] {
		didSet {
			tableView.reloadData()
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.estimatedRowHeight = tableView.rowHeight
		tableView.rowHeight = UITableViewAutomaticDimension
    }
	
	init() { super.init(nibName: "GenericTableViewController", bundle: nil) }
	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as Cell
		cell.viewModel = self.viewModel[indexPath.row]
		return cell
	}
}
