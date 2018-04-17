//
//  ViewController.swift
//  TestApp
//
//  Created by Nicolas Landa on 16/2/17.
//  
//

import UIKit
import ATLibrary

class ViewController: UIViewController {
	
	var callback: DelegatedCall<String>?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		let a = "asdas"
		
		callback?.delegate(to: self, with: { (self, string) in
			
		})
		
		callback?.callback?("")
    }
}
