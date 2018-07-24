//
//  GameViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/23/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class GameViewController: NSViewController, GameViewDelegate, ClientModelControllerDelegate {
    
    var clientModelController:ClientModelController!
    var hash_value:Int = 0
    var direction:CGVector = .zero
    var engagedDirections:[Direction:Bool] = [
        .UP:false,
        .DOWN:false,
        .RIGHT:false,
        .LEFT:false,
    ]
    
    @IBOutlet var gameView: GameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("bra!")
        gameView.delegate = self
        clientModelController.delegate = self
    }
    
    func engageDirection(_ direction: Direction) {
        engagedDirections[direction] = true
        updateDirection()
    }
    
    func disgageDirection(_ direction: Direction) {
        engagedDirections[direction] = false
        updateDirection()
    }
    
    func updateDirection(){
        var result = CGVector.zero
        for (dir, eng) in engagedDirections where eng{
            result = result + DirectionVector[dir]!
        }
        self.hash_value = clientModelController.sendControlPack(dx: Float(result.dx), dy: Float(result.dy), angle: 1.0)
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let dest = segue.destinationController as? ConnectionViewController{
            dest.clientModelController = self.clientModelController
        }
    }
    
    func receiveServerOpPacket(packet: ServerOpPacket) {
        switch packet.server_code {
        case SERVER_EXIT:
            clientModelController.overlayData!.notification = "Server disconnected"
            DispatchQueue.main.sync {
                self.performSegue(withIdentifier: "segueConnection", sender: nil)
            }
        default:
            print("unrecognized serverop of \(packet.server_code)")
        }
    }
    
    deinit {
        print("gameviewcontroller... GONE!")
    }
}

let DirectionVector:[Direction:CGVector] = [
    .UP:CGVector(dx: 0, dy: 1),
    .DOWN:CGVector(dx: 0, dy: -1),
    .RIGHT:CGVector(dx: 1, dy: 0),
    .LEFT:CGVector(dx: -1, dy: 0),
]

