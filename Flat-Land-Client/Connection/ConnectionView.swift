//
//  InitView.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class ConnectionView: NSView {

    @IBOutlet weak var addressTextField: NSTextField!
    @IBOutlet weak var portTextField: NSTextField!
    
    @IBOutlet weak var connectButton: NSButton!
    weak var connectionViewDelegate:ConnectionViewDelegate?
    
    @IBAction func connect(_ sender: Any) {
        guard let delegate = self.connectionViewDelegate else {print("not init view delegate,e xiting init view");return;}
        let add = addressTextField.stringValue == "" ? addressTextField.placeholderString! :addressTextField.stringValue
        let port = Int32(portTextField.stringValue == "" ? portTextField.placeholderString!:portTextField.stringValue)!
        delegate.connectToServer(address: add, port: port)
    }
    
    @IBAction func clicked(_ sender: Any) {
        self.window!.resignFirstResponder()
        self.window!.makeFirstResponder(nil)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func keyDown(with event: NSEvent) {
        guard let char = event.characters else { print("not a recognized key");return}
        switch(char){
        case "w":
            print("goup")
        case "s":
            print("godown")
        case "d":
            print("goright")
        case "a":
            print("goleft")
        default:
            print("default")
        }
    }
    
}

protocol ConnectionViewDelegate: class {
    func connectToServer(address:String, port:Int32)
}
