//
//  ClientModelController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

public class ClientModelController{
    
    let client:ClientUDP
    
    init(address:String, port:Int32) {
        self.client = ClientUDP(address:address, port: port)
    }
    
    func startConnection(){
        client.startClient()
    }
    
    func sendInitPack(name:String, id:Int8, config:Int8){
        let nameptr = UnsafeMutablePointer<Int8>(mutating: (NSString(string: name).utf8String!))//no need to free
        let initPacketPtr = getInitPacket(nameptr, id, config)
        client.sendData(Data(bytes: initPacketPtr!, count: MemoryLayout<PlayerInitPacket>.size), address: nil)
        free(initPacketPtr)
    }
    
    func sendMessage(_ message:String) {
        self.client.sendMessage(message, address: nil)
        
    }
    
    func sendData(_ data:Data){
        self.client.sendData(data, address: nil)
    }
}
