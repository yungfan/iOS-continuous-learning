//
//  ViewController.swift
//  BackgroundTasksDemo
//
//  Created by 杨帆 on 2022/7/7.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        checkBackgroundRefreshStatus()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(backgroundRefreshStatusDidChange),
                                               name: UIApplication.backgroundRefreshStatusDidChangeNotification,
                                               object: nil)
    }

    @objc
    func backgroundRefreshStatusDidChange(notification: NSNotification) {
        print("当前状态: \(UIApplication.shared.backgroundRefreshStatus)")
    }

    // MARK: 检查后台应用程序刷新权限
    func checkBackgroundRefreshStatus() {
        switch UIApplication.shared.backgroundRefreshStatus {
        case .available:
            print("后台应用程序刷新权限开启")
        case .denied:
            print("后台应用程序刷新权限禁用")
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        case .restricted:
            print("后台应用程序刷新权限受限")
        default:
            print("Unknown")
        }
    }
}
