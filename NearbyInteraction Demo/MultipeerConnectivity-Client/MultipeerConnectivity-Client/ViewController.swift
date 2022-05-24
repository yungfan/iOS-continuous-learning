//
//  ViewController.swift
//  MultipeerConnectivity-Client
//
//  Created by student on 2021/12/6.
//

import MultipeerConnectivity
import NearbyInteraction
import UIKit

class ViewController: UIViewController {
    var session: MCSession!
    var niSession: NISession?
    // 用于发现与连接服务端的UIViewController
    var browserController: MCBrowserViewController!

    lazy var label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        label.center = view.center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)

        let peerID = MCPeerID(displayName: "Browser")
        session = MCSession(peer: peerID)
        session.delegate = self

        setupSession()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // serviceType要保持与服务端一致
        browserController = MCBrowserViewController(serviceType: "test-ni", session: session)
        browserController.delegate = self
        present(browserController, animated: true, completion: nil)
    }
}

extension ViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
}

extension ViewController {
    // MARK: 设置NISession
    func setupSession() {
        guard NISession.isSupported else {
            print("NearbyInteraction在当前设备不可用")
            return
        }
        // 创建NISession
        niSession = NISession()
        // 设置代理
        niSession?.delegate = self
    }

    // MARK: 发送NISession的discoveryToken给其他设备
    func sendDiscoveryTokenToPeer() {
        guard let myToken = niSession?.discoveryToken else {
            return
        }
        if let encodedToken = try? NSKeyedArchiver.archivedData(withRootObject: myToken, requiringSecureCoding: true) {
            // 通过MultipeerConnectivity发送discoveryToken
            do {
                // 发送消息
                try session.send(encodedToken, toPeers: session.connectedPeers, with: .unreliable)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // MARK: 获取其他设备发送的discoveryToken
    func receiveDiscoveryTokenFromPeer(peerTokenData: Data) {
        guard let peerDiscoveryToken = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: peerTokenData) else {
            return
        }
        // 创建配置
        let config = NINearbyPeerConfiguration(peerToken: peerDiscoveryToken)
        // 运行NISession
        niSession?.run(config)
    }
}

// MARK: - NISessionDelegate
extension ViewController: NISessionDelegate {
    // MARK: 接收到附近设备的最新信息
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        print(#function)
        if let nearbyObject = nearbyObjects.first {
            print("Client:", nearbyObject.discoveryToken, "距离:\(nearbyObject.distance)", "方位:\(nearbyObject.direction)")
            self.label.text = "距离:\(nearbyObject.distance)"
        }
    }

    // MARK: 会话不再与附近设备交互
    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
        print(#function)
    }

    // MARK: 会话状态暂停
    func sessionWasSuspended(_ session: NISession) {
        print(#function)
    }

    // MARK: 会话状态结束
    func sessionSuspensionEnded(_ session: NISession) {
        print(#function)
    }

    // MARK: 会话状态失效
    func session(_ session: NISession, didInvalidateWith error: Error) {
        print(#function)
    }
}

extension ViewController: MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.receiveDiscoveryTokenFromPeer(peerTokenData: data)
            self.sendDiscoveryTokenToPeer()
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
