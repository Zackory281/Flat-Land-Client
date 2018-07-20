//
//  InitView.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class InitView: NSView {

    @IBOutlet weak var addressTextField: NSTextField!
    @IBOutlet weak var portTextField: NSTextField!
    
    @IBOutlet weak var connectButton: NSButton!
    var initViewDelegate:InitViewDelegate?
    
    @IBAction func connect(_ sender: Any) {
        guard let delegate = self.initViewDelegate else {print("not init view delegate,e xiting init view");return;}
        let add = addressTextField.placeholderString ?? addressTextField.stringValue
        let port = Int32(portTextField.placeholderString ?? portTextField.stringValue)!
        delegate.connectToServer(address: add, port: port, name: "blowa", id: 45, config: 89)
    }
    
    let gest = NSPressGestureRecognizer(target: self, action: #selector(clickedBackground))
    
    @objc func clickedBackground() {
        print("I am clicked")
        
        //addressTextField.resignFirstResponder()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        self.addGestureRecognizer(gest)
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

protocol InitViewDelegate {
    func connectToServer(address:String, port:Int32, name:String, id:Int8, config:Int8)
}
