//
//  ViewController.swift
//  MultipeerConnectivity-Client
//
//  Created by student on 2021/12/6.
//

import MultipeerConnectivity
import UIKit

class ViewController: UIViewController {
    var session: MCSession!
    // 用于发现与连接服务端的UIViewController
    var browserController: MCBrowserViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let peerID = MCPeerID(displayName: "Browser")
        session = MCSession(peer: peerID)
        session.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // serviceType要保持与服务端一致
        browserController = MCBrowserViewController(serviceType: "test-mc", session: session)
        browserController.delegate = self
        present(browserController, animated: true, completion: nil)
    }
}

extension ViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    }
}

extension ViewController: MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            print("Client：", String(data: data, encoding: .utf8))

            self.view.backgroundColor = .green

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // 回复信息
                do {
                    try session.send("Hello Sever".data(using: .utf8)!, toPeers: session.connectedPeers, with: .unreliable)
                } catch {
                    print(error.localizedDescription)
                }
            }
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
            // 连上以后回到主界面
            DispatchQueue.main.async {
                self.browserController.dismiss(animated: true, completion: nil)
            }
        case .notConnected:
            print("没有连接")
        case .connecting:
            print("正在连接")
        default:
            print("连接失败")
        }
    }
}
