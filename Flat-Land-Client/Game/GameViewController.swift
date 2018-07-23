//
//  GameViewController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/23/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class GameViewController: NSViewController {

    var clientModelController:ClientModelController!
    var hash_value:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("bra!")
    }
    
    @IBAction func goUp(_ sender: Any) {
        self.hash_value = clientModelController.sendControlPack(direction: UP, angle: 1.0)
    }
}
