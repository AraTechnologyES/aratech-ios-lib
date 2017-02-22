//
//  ViewController.swift
//  TestApp
//
//  Created by Aratech iOS on 16/2/17.
//  Copyright © 2017 AraTech. All rights reserved.
//

import UIKit
import Utils

class ViewController: UIViewController {
    
    @IBOutlet weak var button: StyleableButton! {
        didSet {
            button.style = .default
        }
    }
    
    @IBOutlet weak var textField: StyleableTextField! {
        didSet {
            textField.style = .default
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
