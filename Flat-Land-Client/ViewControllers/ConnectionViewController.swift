//
//  InitViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class ConnectionViewController: NSViewController, ConnectionViewDelegate {

    @IBOutlet var connectionView: ConnectionView!
    
    var clientModelController:ClientModelController?
    @IBOutlet weak var clickGesture: NSClickGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        connectionView.connectionViewDelegate = self
        clickGesture.delaysPrimaryMouseButtonEvents = false
    }
    
    func connectToServer(address: String, port: Int32, name: String, id: Int8, config: Int8) {
        clientModelController = ClientModelController(address: address, port: port)
        clientModelController!.startConnection()
        clientModelController!.sendInitPack(name: name, id: id, config: config)
        performSegue(withIdentifier: "toInitViewController", sender: nil)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let initViewController = segue.destinationController as? InitViewController {
            initViewController.clientModelController = self.clientModelController
        }
    }
    
    override func viewWillDisappear() {
        print("will will disappear")
    }
    deinit {
        self.view.removeFromSuperview()
        print("Connectionviewcontroller... GONE!")
    }
}


