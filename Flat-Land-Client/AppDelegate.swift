//
//  AppDelegate.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var str = String(stringLiteral: "bra")

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("app launched")
        guard let initViewController = NSApplication.shared.mainWindow?.contentViewController as? InitViewController else {
            print("not the right init view controller, can't inject clientmodelcontroller at launch")
            return
        }
        //let a = ClientModelController(address: "localhost", port: 8080)
        //initViewController.clientModelController = a
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

