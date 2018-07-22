//
//  ClientUDP.swift
//  Sockets
//
//  Created by Zackory Cramer on 7/16/18.
//

import Foundation
import Socket

typealias MessageInfo = (bytesRead: Int, address: Socket.Address?)

class ClientUDP {
    
    var port:Int32
    var addressIP:String
    var socket:Socket!
    var clientListenQueue = DispatchQueue(label: "client.listen",attributes: .concurrent)
    var clientSendQueue = DispatchQueue(label: "client.write",attributes: .concurrent)
    var active = true
    var serverAddress:Socket.Address?
    
    init(address:String="localhost", port:Int32=8080) {
        self.port = port
        self.addressIP = address
        self.serverAddress = Socket.createAddress(for: address, on: port)
    }
    
    func startClient(){
        do{
            try self.socket = Socket.create(family: .inet, type: .datagram, proto: .udp)
            print("client established")
        }catch{
            print("error connecting to socket \(error)")
        }
    }
    
    func enableSendData() {//192.168.0.18
        let address = Socket.createAddress(for: self.addressIP, on: self.port)!
        clientSendQueue.sync { [unowned self] in
            repeat{
                do{
                    let message = readLine()!
                    if message == "EXIT"{
                        self.active = false
                        break
                    }else if message == "w" || message == "s"{
                        var controlPacket = PlayerPacket(controlPacket: PlayerControlPacket(opcode: 1, direction: UP, angle: 3.12))
                        try self.socket!.write(from: Data(bytes: &controlPacket, count: MemoryLayout<PlayerControlPacket>.size), to: address)
                    }else if message == "i"{
                        var initPacket = PlayerPacket(initPacket: PlayerInitPacket(opcode: 0,name: (34,65,75,66,77,88), id: 42, config: 21))
                        try self.socket!.write(from: Data(bytes: &initPacket, count: MemoryLayout<PlayerInitPacket>.size), to: address)
                    }else{
                        try self.socket!.write(from: message, to: address)
                        print("sent \(message)")
                    }
                }catch{
                    print("error sending datagram\(error)")
                }
            }while self.active
            print("Stopped sending data, closing socket...")
            self.socket.close()
        }
    }
    
    func sendMessage(_ message:String, address:Socket.Address?){
        guard let address = address ?? self.serverAddress else { print("no address to write to"); return}
        do{
            try socket.write(from: message, to: address)
        }catch{
            print("failed to write message \(message) to address")
        }
    }
    
    func sendData(_ data:Data, address:Socket.Address?){
        guard let address = address ?? self.serverAddress else { print("no address to write to"); return}
        do{
            try socket.write(from: data, to: address)
        }catch{
            print("failed to write data \(data) to address")
        }
    }
    
    func startListeningData(){
        clientListenQueue.async { [unowned self] in
            var readData = Data(capacity: 2048)
            repeat{
                do{
                    let _ = try self.socket.readDatagram(into: &readData)
                    self.decodeListenedData(data: readData)
                }catch{
                    print("failed to read datagram: \(error)")
                }
                readData.count = 0
            }while self.active
            print("Stopped reading data, closing socket...")
        }
    }
    
    func decodeListenedData(data:Data){
        data.withUnsafeBytes { (ptr:UnsafePointer<PlayerPacket>) in
            switch Int32(ptr.pointee.initPacket.opcode) {
            case Check_opcode:
                print(ptr.pointee.connectionCheckPacket)
            default:
                print("uncognized opcode of \(ptr.pointee.initPacket.opcode)")
            }
        }
    }
}
