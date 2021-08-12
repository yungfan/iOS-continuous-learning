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

        if #available(iOS 13.0, *) {
            // UINavigationBar
            let navigationBarAppearance = UINavigationBarAppearance()
            // 背景色
            navigationBarAppearance.backgroundColor = .red
            // 按钮文字颜色(未发现调整图片颜色的API)
            navigationBarAppearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBarAppearance.buttonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBarAppearance.doneButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBarAppearance.doneButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.white]
            // 标题文字颜色
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            // 生效
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance

            // UITabBar
            let tabBarAppearance = UITabBarAppearance()
            // 背景色
            tabBarAppearance.backgroundColor = .red
            // 设置UITabBarItem
            let itemAppearance = UITabBarItemAppearance()
            // 未选中的图标颜色
            itemAppearance.normal.iconColor = .black
            // 未选中的文字颜色
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            // 角标背景色
            itemAppearance.normal.badgeBackgroundColor = .black
            // 角标颜色
            itemAppearance.normal.badgeTextAttributes = [.foregroundColor: UIColor.white]
            // 选中的图标颜色
            itemAppearance.selected.iconColor = .white
            // 选中的文字颜色
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
            // 选中的角标背景色
            itemAppearance.selected.badgeBackgroundColor = .white
            // 选中的角标颜色
            itemAppearance.selected.badgeTextAttributes = [.foregroundColor: UIColor.black]
            // 生效
            tabBarAppearance.stackedLayoutAppearance = itemAppearance
            tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
            tabBarController?.tabBar.standardAppearance = tabBarAppearance

            // 工具栏
            let toolBarAppearance = UIToolbarAppearance()
            toolBarAppearance.backgroundColor = .blue
            navigationController?.toolbar.scrollEdgeAppearance = toolBarAppearance
            navigationController?.toolbar.standardAppearance = toolBarAppearance
        } else {
            navigationController?.navigationBar.barTintColor = .red
            navigationController?.toolbar.barTintColor = .blue
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            tabBarController?.tabBar.barTintColor = .red
            tabBarController?.tabBar.tintColor = .black
            tabBarController?.tabBar.unselectedItemTintColor = .white
            tabBarItem.badgeColor = .black
            tabBarItem.setBadgeTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        }
    }
}
