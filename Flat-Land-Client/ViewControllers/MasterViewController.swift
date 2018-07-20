//
//  MasterViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {

    @objc dynamic var overlayData = OverlayData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    class OverlayData:NSObject{
        var notification:String = "no notifications yet"
    }
    
}
