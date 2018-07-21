//
//  MasterViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = NSStoryboard(name: "Main", bundle: Bundle.main)
        let connectionViewController = storyboard.instantiateController(withIdentifier: "ConnectionViewController") as! ConnectionViewController
        self.addChild(connectionViewController)
        view.addSubview(connectionViewController.view)
        connectionViewController.view.frame = view.bounds
        self.overlayData.str = "sdf"
        //self.object.setValue("str bra", forKey: "str")
    }
    
    @IBOutlet weak var statusLabel: NSTextField!
    @objc dynamic var overlayData = OverlayData()
    
    @IBOutlet var object: NSObjectController!
}

class OverlayData:NSDictionary{
    var notification:NSString = "no notifications yet"
    var str:NSString = "no notifications yet2"
}
