//
//  InitViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/20/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class InitViewController: NSViewController, NSTextFieldDelegate, ClientModelControllerDelegate{

    var clientModelController:ClientModelController!
    var dataHash:Int = 0
    @objc dynamic var initData:InitData = InitData()
    @IBOutlet weak var name: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clientModelController.delegate = self
    }
    
    @IBAction func join(_ sender: Any) {
        let name = self.name.stringValue
        clientModelController.overlayData!.notification = NSString(string: name)
        self.dataHash = clientModelController.sendInitPack(name: name, id: 23, config: 43)
    }
    
    func receiveConnectionCheckPacket(packet: PlayerConnectionCheckPacket) {
        if packet.hash == self.dataHash{
            DispatchQueue.main.sync {
                self.performSegue(withIdentifier: "segueToGame", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let dest = segue.destinationController as? GameViewController{
            dest.clientModelController = self.clientModelController
        }
    }
}

class InitData:NSObject{
    @objc dynamic var name:NSString?
}
