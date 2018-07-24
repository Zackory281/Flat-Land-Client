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
        clientModelController.delegate = self
        connectionView.connectionViewDelegate = self
        clickGesture.delaysPrimaryMouseButtonEvents = false
    }
    
    func connectToServer(address:String, port:Int32) {
        clientModelController.setupConnection(address: address, port: port)
        clientModelController.startConnection()
        clientModelController.sendConnectionCheckPack(hash: 1234)
    }
    
    func receiveConnectionCheckPacket(packet: PlayerConnectionCheckPacket) {
        print("received check hash of \(packet.hash)")
        segue()
    }
    
    func segue(){
        DispatchQueue.main.sync {
            performSegue(withIdentifier: "toInitViewController", sender: nil)
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let initViewController = segue.destinationController as? InitViewController {
            initViewController.clientModelController = self.clientModelController
        }
    }
    
    deinit {
        self.view.removeFromSuperview()
        print("Connectionviewcontroller... GONE!")
    }
}

class ConnectionData: NSObject {
    @objc dynamic var address:NSString?
    @objc dynamic var port:NSString?
}
