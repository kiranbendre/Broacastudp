//
//  ViewController.swift
//  BroadcastUDP
//
//  Created by Iphone XR on 08/12/22.
//

import UIKit
import CocoaAsyncSocket

class ViewController: UIViewController,GCDAsyncUdpSocketDelegate {
    
    var address = "255.255.255.255"
    var port:UInt16 = 5984
    var socket:GCDAsyncUdpSocket!
    var socketReceive:GCDAsyncUdpSocket!
    var error : NSError?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let message = "SOUL".data(using: String.Encoding.utf8)
       
        socket = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        socket.delegate()
        
        do {
            try socket.enableReusePort(true)
            try socket.bind(toPort: port)
            try socket.enableBroadcast(true)
            try socket.beginReceiving()
            //socket.delegate()
            } catch {
              print(error)
          }
        print(message!,address,port)
         
        socket.send(message!, toHost: address, port: port, withTimeout: -1, tag: 0)
        
        }

            func udpSocket(sock: GCDAsyncUdpSocket!, didConnectToAddress address: NSData!) {
                print("didConnectToAddress");
            }

            func udpSocket(sock: GCDAsyncUdpSocket!, didNotConnect error: NSError!) {
                print("didNotConnect \(error)")
            }

            func udpSocket(sock: GCDAsyncUdpSocket!, didSendDataWithTag tag: Int) {
                print("didSendDataWithTag")
            }

            func udpSocket(sock: GCDAsyncUdpSocket!, didNotSendDataWithTag tag: Int, dueToError error: NSError!) {
                print("didNotSendDataWithTag")
            }

        func udpSocket(sock: GCDAsyncUdpSocket!, didReceiveData data: Data, fromAddress address: Data, withFilterContext filterContext: AnyObject!) {
             print("receive data")
            
            var host: NSString?
            var port1: UInt16 = 0
            
            GCDAsyncUdpSocket.getHost(&host, port: &port1, fromAddress: address as Data)
            print("From \(host!)")

            let gotdata: NSString = NSString(data: data as Data, encoding: NSUTF8StringEncoding)!
            print(gotdata)

        }

        }
    



       
