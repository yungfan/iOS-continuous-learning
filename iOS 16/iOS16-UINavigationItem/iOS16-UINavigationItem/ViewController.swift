//
//  ViewController.swift
//  iOS16-UINavigationItem
//
//  Created by 杨帆 on 2022/8/24.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        // 左侧
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(gotoNextViewController)),
            UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)]

        // 标题
        navigationItem.title = "导航栏"
        // navigationItem.titleView = UISwitch()

        // 中间
        let fixedGroup = UIBarButtonItemGroup.fixedGroup(items: [
            UIBarButtonItem(title: "撤销", image: UIImage(systemName: "arrow.uturn.backward"),
                            primaryAction: UIAction { _ in
                            }),
            UIBarButtonItem(title: "反撤销", image: UIImage(systemName: "arrow.uturn.forward"),
                            primaryAction: UIAction { _ in
                            })])
        let movableGroup = UIBarButtonItem(title: "裁剪", image: UIImage(systemName: "crop"),
                                           primaryAction: UIAction { _ in
                                           }).creatingMovableGroup(customizationIdentifier: "Cropping")
        navigationItem.centerItemGroups = [fixedGroup, movableGroup]

        // 右侧
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)]

        // 设置style
        navigationItem.style = .editor
    }

  
    @objc func gotoNextViewController(_ sender: UIBarButtonItem) {
        let nextViewController = UIViewController()
        nextViewController.view.backgroundColor = .red
        nextViewController.navigationItem.title = "下一页"

        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

