//
//  ViewController.swift
//  MultipeerConnectivity-Server
//
//  Created by student on 2021/12/6.
//

import MultipeerConnectivity
import UIKit

class ViewController: UIViewController {
    var session: MCSession!
    var advertiserAssistant: MCNearbyServiceAdvertiser!

    override func viewDidLoad() {
        super.viewDidLoad()

        let peerID = MCPeerID(displayName: "Advertiser")
        session = MCSession(peer: peerID)
        session.delegate = self
        // 客户端的serviceType要一致
        advertiserAssistant = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "test-mc")
        advertiserAssistant.delegate = self
        advertiserAssistant.startAdvertisingPeer()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        do {
            // 发送消息
            try session.send("Hello Client".data(using: .utf8)!, toPeers: session.connectedPeers, with: .unreliable)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
}

extension ViewController: MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // 接收客户端发来的信息
        DispatchQueue.main.async {
            print("Server：", String(data: data, encoding: .utf8))
            self.view.backgroundColor = .red
        }
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("已经连接")
        case .notConnected:
            print("没有连接")
        case .connecting:
            print("正在连接")
        default:
            print("连接失败")
        }
    }
}
