//
//  ViewController.swift
//  JKTButtonExt
//
//  Created by Jeethu on 28/05/15.
//  Copyright (c) 2015 jeethukthomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClick(sender: AnyObject) {
        
        var theBtn : UIButton = (sender as? UIButton)!
       theBtn.loadBtn(color: UIColor.purpleColor(), needRoundEdge: true)
        
    }

}
