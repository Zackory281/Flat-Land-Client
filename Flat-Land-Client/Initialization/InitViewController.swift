//
//  InitViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/20/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class InitViewController: NSViewController {

    var clientModelController:ClientModelController!
    @objc dynamic var initData:InitData = InitData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clicked(_ sender: Any) {
        print("clicked")
    }
    @IBAction func join(_ sender: Any) {
    }
}

class InitData:NSObject{
    @objc dynamic var name:NSString?{
        didSet{
            print("just set")
        }
    }
}
