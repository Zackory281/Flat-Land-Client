//
//  GameView.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/23/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class GameView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        print("drawing")
    }
    
    override func keyDown(with event: NSEvent) {
        print("key down!")
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
}
