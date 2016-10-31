//
//  Spinner.swift
//  Utils

import Foundation

// MARK:- Activity indicator

public func showSpinner(inNavigationItem navigationItem: UINavigationItem) {
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    spinner.startAnimating()
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
}

public func hideSpinner(ofNavigationItem navigationItem: UINavigationItem) {
    if let button = navigationItem.rightBarButtonItem,
        let spinner = button.customView as? UIActivityIndicatorView {
        spinner.stopAnimating()
    }
}
