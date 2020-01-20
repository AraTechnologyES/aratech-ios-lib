//
//  AlertController+Extension.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 12/03/2019.
//  
//

import UIKit

public extension UIAlertController {

	public class func present(
		into viewController: UIViewController,
		title: String? = nil,
		body: String? = nil,
		during: DispatchTime? = nil) {

		let alert = UIAlertController(
			title: title,
			message: body,
			preferredStyle: .alert)

		if during == nil {
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
				alert.dismiss(animated: true, completion: nil)
			}))
		}

		viewController.present(alert, animated: true) {
			if let delay = during {
				execute(in: .main, delay: delay) {
					alert.dismiss(animated: true, completion: nil)
				}
			}
		}
	}
}
