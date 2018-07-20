//
//  InitViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class InitViewController: NSViewController, InitViewDelegate {

    @IBOutlet var initView: InitView!
    
    var clientModelController:ClientModelController?
    @IBOutlet weak var clickGesture: NSClickGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        initView.initViewDelegate = self
        clickGesture.delaysPrimaryMouseButtonEvents = false
    }
    
    func connectToServer(address: String, port: Int32, name: String, id: Int8, config: Int8) {
        clientModelController = ClientModelController(address: address, port: port)
        clientModelController!.startConnection()
        clientModelController!.sendInitPack(name: name, id: id, config: config)
    }
}


