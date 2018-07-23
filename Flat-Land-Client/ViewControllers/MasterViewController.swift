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
        connectionViewController.clientModelController = ClientModelController()
        connectionViewController.clientModelController.overlayData = self.overlayData
        self.addChild(connectionViewController)
        view.addSubview(connectionViewController.view)
        connectionViewController.view.frame = view.bounds
    }
    
    @IBOutlet weak var statusLabel: NSTextField!
    @objc dynamic var overlayData = OverlayData("No status yet.", 17)
}

class OverlayData: NSObject{
    @objc dynamic var notification:NSString
    @objc dynamic var age:NSInteger
    
    init(_ notification:NSString, _ age:NSInteger) {
        self.notification = notification
        self.age = age
    }
}
