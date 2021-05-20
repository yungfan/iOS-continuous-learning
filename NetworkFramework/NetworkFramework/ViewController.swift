//
//  ViewController.swift
//  NetworkFramework
//
//  Created by 杨帆 on 2019/7/30.
//  Copyright © 2019 杨帆. All rights reserved.
//

import UIKit
import Network

class ViewController: UIViewController {
    
    
    //连接参数
    var params: NWParameters!
    
    //连接对象
    var connection: NWConnection!
    
    //队列
    let myQueue = DispatchQueue.global()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setParams()

    }
    
    
    
    //1. 开始建立连接
    @IBAction func connect(_ sender: Any) {
        
        self.connect()
        
    }
    
    //2. 发送数据
    @IBAction func send(_ sender: Any) {
        
        sendData()
        
    }
    
    //3. 接收数据
    @IBAction func receive(_ sender: Any) {
        
        receiveData()
        
    }
    
    
}


extension ViewController {
    
    //可自定义设置连接参数
    private func setParams(){
        
        //使用 TCP 协议
        self.params = NWParameters.tcp
        
        //仅使用蜂窝网络、 Wifi
        params.prohibitedInterfaceTypes = [.wifi, .cellular]
 
        //使用 IPv6 协议
        if let ipOption = params.defaultProtocolStack.internetProtocol as? NWProtocolIP.Options {
            
            ipOption.version = .v6
        }
        
        //禁止代理
        params.preferNoProxies = true
        
    }
    
    
    //连接
    private func connect() {
        //创建连接对象
        self.connection = NWConnection(host: NWEndpoint.Host("192.168.0.175"),
                                       port: NWEndpoint.Port(integerLiteral: 9999), using: self.params)
        
        //开始连接
        self.connection.start(queue: self.myQueue)
        
        //监听连接状态
        self.connection.stateUpdateHandler = {
            
            (newState) in
            
            switch newState {
                
            case .ready:
                
                print("state ready")
                
                //self.sendData()
                //self.receiveData()
                
            case .cancelled:
                
                print("state cancel")
                
            case .waiting(let error):
                
                print("state waiting \(error)")
                
            case .failed(let error):
                
                print("state failed \(error)")
                
            default:
                break
            }
            
        }
        
        
    }
    
    
    //发送数据
    private func sendData(){
        
        let content = "你好，我是iOS客户端"
        
        self.connection?.send(content: content.data(using: .utf8), completion: .contentProcessed({ (sendError) in
            
            if let sendError = sendError {
                
                print(sendError)
                
            } else {
                
                print("消息已发送，内容为: \(content)")
            }
            
        }))
        
        
    }
    
    
    //接收数据
    private func receiveData(){
        
        self.connection.receiveMessage(completion: { (content, context, isComplete, receError) in
            
            if let receError = receError {
                
                print(receError)
                
            } else {
                
                let data = String(data: content ?? "empty".data(using: .utf8)!, encoding: .utf8)
                
                print(data!)
            }
            
            if isComplete {
                
                //关闭资源
                //self.connection.cancel()
                
            }
        })
        
        
    }
    
}
