//
//  Window.swift
//  ATLibrary
//
//  Created by Nicolás Landa on 04/12/2018.
//  
//

extension UIWindow {
	
	public class func topViewController(rootViewController: UIViewController) -> UIViewController {
		if let navigationController = rootViewController as? UINavigationController {
			if let visibleViewController = navigationController.visibleViewController {
				return topViewController(rootViewController: visibleViewController)
			}
		}
		
		if let tabBarController = rootViewController as? UITabBarController {
			if let selectedViewController = tabBarController.selectedViewController {
				return topViewController(rootViewController: selectedViewController)
			}
		}
		
		if let presentedViewController = rootViewController.presentedViewController {
			return topViewController(rootViewController: presentedViewController)
		}
		
		return rootViewController
	}
}
