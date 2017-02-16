//
//  ViewController.swift
//  TestApp
//
//  Created by Aratech iOS on 16/2/17.
//  Copyright © 2017 AraTech. All rights reserved.
//

import UIKit
import Utils

class SourceViewController: UIViewController {

    let animationManager = SlideAnimationManager(forSegue: "menu", interactive: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animationManager.source = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self.animationManager
        self.animationManager.destination = segue.destination
    }
}

class DestinationViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
