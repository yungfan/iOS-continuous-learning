//
//  ViewController.swift
//  06-UINavigationBar、UIToolbar和UITabBar
//
//  Created by 杨帆 on 2021/7/8.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
            // 导航栏
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = .red
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
            // 工具栏
            let toolBarAppearance = UIToolbarAppearance()
            toolBarAppearance.backgroundColor = .blue
            navigationController?.toolbar.scrollEdgeAppearance = toolBarAppearance
            navigationController?.toolbar.standardAppearance = toolBarAppearance
            // 标签栏
            let tabBarAppearance = UITabBarAppearance()
            toolBarAppearance.backgroundColor = .purple
            tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
            tabBarController?.tabBar.standardAppearance = tabBarAppearance
        } else {
            navigationController?.navigationBar.barTintColor = .red
            navigationController?.toolbar.barTintColor = .blue
            tabBarController?.tabBar.barTintColor = .purple
        }
    }
}
