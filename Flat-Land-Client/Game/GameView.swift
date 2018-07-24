//
//  GameView.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/23/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class GameView: NSView {

    weak var delegate:GameViewDelegate?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func keyDown(with event: NSEvent) {
        guard let change = delegate?.engageDirection else {print("no game view delegate");return;}
        forKeyCode(code:event.keyCode, method:change)
        print("down")
    }
    
    override func keyUp(with event: NSEvent) {
        guard let change = delegate?.disgageDirection else {print("no game view delegate");return;}
        forKeyCode(code:event.keyCode, method:change)
    }
    
    func forKeyCode(code:UInt16, method:(_ direction:Direction) -> ()){
        switch code {
        case 13://w
            method(.UP)
        case 0://a
            method(.LEFT)
        case 1://s
            method(.DOWN)
        case 2://d
            method(.RIGHT)
        default:
            print("not a recognized key code \(code)")
        }
    }
    
    override func becomeFirstResponder() -> Bool {return true}
    override var acceptsFirstResponder: Bool{ return true}
    override func resignFirstResponder() -> Bool {return true}
    
}

protocol GameViewDelegate: class {
    func engageDirection(_ direction:Direction)
    func disgageDirection(_ direction:Direction)
}

enum Direction{
    case UP
    case LEFT
    case DOWN
    case RIGHT
}
