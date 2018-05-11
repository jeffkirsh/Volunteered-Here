//
//  ViewController.swift
//  Volunteered Here
//
//  Created by Dad on 5/2/18.
//  Copyright © 2018 Jeff Kirshenbaum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    var isSlideMenuHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //initialize constant with 0
        sideMenuConstraint.constant = -165
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuBtnPressed(_ sender: UIBarButtonItem) {
        
        if isSlideMenuHidden {
            sideMenuConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
                })
        } else {
            sideMenuConstraint.constant = -165
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isSlideMenuHidden = !isSlideMenuHidden
        
    }
    
}

