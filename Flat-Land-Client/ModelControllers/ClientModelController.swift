//
//  ClientModelController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

public class ClientModelController{
    
    var client:ClientUDP?
    var overlayData:OverlayData?
    
    func setupConnection(address:String, port:Int32){
        if let _ = self.client {
            print("overriding existing client")
        }
        self.client = ClientUDP(address: address, port: port)
    }
    
    func startConnection(){
        guard let client = self.client else { print("no client avaliable to start conn.");return}
        client.startClient()
    }
    
    func sendInitPack(name:String, id:Int8, config:Int8){
        guard let client = self.client else { print("no client avaliable to send init pack");return}
        let nameptr = UnsafeMutablePointer<Int8>(mutating: (NSString(string: name).utf8String!))//no need to free
        let initPacketPtr = getInitPacket(nameptr, id, config)
        client.sendData(Data(bytes: initPacketPtr!, count: MemoryLayout<PlayerInitPacket>.size), address: nil)
        free(nameptr)
        free(initPacketPtr)
    }
    
    func sendMessage(_ message:String) {
        guard let client = self.client else {
            print("no client avaliable to send message")
            return
        }
        client.sendMessage(message, address: nil)
        
    }
    
    func sendData(_ data:Data){
        guard let client = self.client else {
            print("no client avaliable to send data")
            return
        }
        client.sendData(data, address: nil)
    }
}

@objc protocol ClientModelControllerDelegate{
    @objc optional func receiveConnectionCheckPacket(packet:PlayerConnectionCheckPacket)
}
