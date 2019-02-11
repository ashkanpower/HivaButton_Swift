//
//  ViewController.swift
//  HivaButton
//
//  Created by Ashkan Ghodrat on 12/12/18.
//  Copyright © 2018 Ashkan Ghodrat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: HivaButton!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        button.clickListener {

            self.button.startLoading()
            
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                self.button.stopLoading()
            }
        }
//
//        button.toggleListener {
//
//            print(self.button.isOn)
//        }
    }
    
 
}

