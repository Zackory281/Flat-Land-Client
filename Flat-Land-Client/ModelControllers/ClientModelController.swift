//
//  ClientModelController.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/19/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

public class ClientModelController: ClientDelegate{
    
    var client:ClientUDP?
    var overlayData:OverlayData?
    weak var delegate:ClientModelControllerDelegate?
    
    func setupConnection(address:String, port:Int32){
        if let _ = self.client {
            print("overriding existing client")
        }
        self.client = ClientUDP(address: address, port: port)
        self.client!.delegate = self
    }
    
    func startConnection(){
        guard let client = self.client else { print("no client avaliable to start conn.");return}
        client.startClient()
        client.startListeningData()
    }
    
    func sendInitPack(name:String, id:Int8, config:Int8){
        guard let client = self.client else { print("no client avaliable to send init pack");return}
        let nameptr = UnsafeMutablePointer<Int8>(mutating: (NSString(string: name).utf8String!))
        let initPacketPtr = getInitPacket(nameptr, id, config)
        client.sendData(Data(bytes: initPacketPtr!, count: MemoryLayout<PlayerInitPacket>.size), address: nil)
        free(nameptr)
        free(initPacketPtr)
    }
    
    func sendConnectionCheckPack(hash:Int32){
        guard let client = self.client else { print("no client avaliable to send check pack");return}
        let checkPacketPtr = getCheckPacket(hash)
        client.sendData(Data(bytes: checkPacketPtr!, count: MemoryLayout<PlayerConnectionCheckPacket>.size), address: nil)
        free(checkPacketPtr)
        print("send connection check packet")
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
    
    func receiveData(data: Data) {
        guard let delegate = self.delegate else {print("ClientModelController delegate doesn't eixt"); return;}
        data.withUnsafeBytes { (ptr:UnsafePointer<PlayerPacket>) in
            switch Int32(ptr.pointee.initPacket.opcode) {
            case Check_opcode:
                guard let receiveConnection = delegate.receiveConnectionCheckPacket else {print("connectioncheck desont eixt"); return;}
                receiveConnection(ptr.pointee.connectionCheckPacket)
            default:
                print("uncognized opcode of \(ptr.pointee.initPacket.opcode)")
            }
        }
    }
    
    deinit {
        print("clienmodelcontroller... GONE!!!")
    }
}

@objc protocol ClientModelControllerDelegate{
    @objc optional func receiveConnectionCheckPacket(packet:PlayerConnectionCheckPacket)
    //@objc optional func receiveUpdatePacket(packet:Playe)
}
