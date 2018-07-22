//
//  InitViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class ConnectionViewController: NSViewController, ConnectionViewDelegate, ClientModelControllerDelegate {

    @IBOutlet var connectionView: ConnectionView!
    
    var clientModelController:ClientModelController!
    @IBOutlet weak var clickGesture: NSClickGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        connectionView.connectionViewDelegate = self
        clickGesture.delaysPrimaryMouseButtonEvents = false
    }
    
    func connectToServer(address:String, port:Int32) {
        clientModelController.setupConnection(address: address, port: port)
        clientModelController.startConnection()
        //clientModelController.sendInitPack(name: name, id: id, config: config)
        performSegue(withIdentifier: "toInitViewController", sender: nil)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let initViewController = segue.destinationController as? InitViewController {
            initViewController.clientModelController = self.clientModelController
        }
    }
    
    @objc dynamic var connectionData:ConnectionData = ConnectionData()
    
    func receiveConnectionCheckPacket(packet: PlayerConnectionCheckPacket) {
        print("received check hash of \(packet.hash)")
    }
    
    deinit {
        self.view.removeFromSuperview()
        print("Connectionviewcontroller... GONE!")
    }
}

class ConnectionData: NSObject {
    @objc dynamic var address:NSString?
    //@objc dynamic var port:Int
}
