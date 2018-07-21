//
//  Segue.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/20/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Cocoa

class Segue: NSStoryboardSegue {

    override init(identifier: NSStoryboardSegue.Identifier, source sourceController: Any, destination destinationController: Any) {
        super.init(identifier: identifier, source: sourceController, destination: destinationController)
    }
    
    override func perform() {
        //print("chlidren \(CFGetRetainCount(containerViewController.children[0] as CFTypeRef))")
        // build from-to and parent-child view controller relationships
        //let sourceViewController  = self.sourceController as NSViewController
        //let destinationViewController = self.destinationController as NSViewController
        //let containerViewController = sourceViewController.parentViewController! as NSViewController
        let sourceViewController = self.sourceController as! NSViewController
        let destinationViewController = self.destinationController as! NSViewController
        let containerViewController = sourceViewController.parent as! MasterViewController
        containerViewController.insertChild(destinationViewController, at: 1)
        destinationViewController.view.wantsLayer = true
        sourceViewController.view.wantsLayer = true
        
        containerViewController.transition(from: sourceViewController, to: destinationViewController, options: NSViewController.TransitionOptions.slideDown){
            destinationViewController.removeFromParent()
            containerViewController.children.remove(at: 0)
        }
        
    }
}
