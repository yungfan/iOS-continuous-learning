//
//  ViewController.swift
//  Cell Content Configuration
//
//  Created by 杨帆 on 2021/7/27.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // 接收传值
    var phone: String = ""
    var detail: String = ""

    // 通过重写视图的updateConfiguration(using:)进行自定义配置
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        // 内容配置
        let content = UIListContentConfiguration.subtitleCell()
        // 背景配置
        let background = UIBackgroundConfiguration.listPlainCell()
        // 在单元格上设置contentConfiguration或backgroundConfiguration时，每当单元格的配置状态更改时，它都会自动要求配置返回其更新版本，然后将新配置重新应用到单元格中。
        var contentConfig = content.updated(for: state)
        var backgroundConfig = background.updated(for: state)

        // 配置text属性
        contentConfig.textProperties.font = .systemFont(ofSize: 20, weight: .heavy)
        contentConfig.textProperties.color = .systemGreen
        // 配置secondaryText属性
        contentConfig.secondaryTextProperties.font = .systemFont(ofSize: 16, weight: .light)
        contentConfig.secondaryTextProperties.color = .systemGreen
        // 配置image属性
        contentConfig.imageProperties.tintColor = .systemGreen
        // 设置内容
        contentConfig.text = phone
        contentConfig.secondaryText = detail
        contentConfig.image = UIImage(systemName: "iphone")

        // 配置背景
        backgroundConfig.backgroundColor = .systemPurple
        backgroundConfig.cornerRadius = 5

        // 选中背景
        // state可能是normal、highlighted、selected和disabled
        if state.isHighlighted || state.isSelected {
            backgroundConfig.backgroundColor = .systemGray2.withAlphaComponent(0.5)
            contentConfig.textProperties.color = .systemRed
            contentConfig.secondaryTextProperties.color = .systemRed
            contentConfig.imageProperties.tintColor = .systemRed
        }

        // 自定义配置赋值
        contentConfiguration = contentConfig
        backgroundConfiguration = backgroundConfig
    }
}

class ViewController: UIViewController {
    var content: Array<String> = ["iPhone 4", "iPhone 4s", "iPhone 5", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 6s", "iPhone 6s Plus", "iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus", "iPhone X", "iPhone Xs", "iPhone XR", "iPhone Xs Max", "iPhone 11", "iPhone 11 Pro", "iPhone 11 Pro Max", "iPhone 12 mini", "iPhone 12", "iPhone 12 Pro", "iPhone 12 Pro Max"]
    var detailContent: Array<String> = ["iPhone 4 - iOS 4", "iPhone 4s - iOS 5", "iPhone 5 - iOS 6", "iPhone 5s - iOS 7", "iPhone 6 - iOS 8", "iPhone 6 Plus - iOS 8", "iPhone 6s - iOS 9", "iPhone 6s Plus - iOS 9", "iPhone 7 - iOS 10", "iPhone 7 Plus - iOS 10", "iPhone 8 - iOS 11", "iPhone 8 Plus - iOS 11", "iPhone X - iOS 11", "iPhone Xs - iOS 12", "iPhone XR - iOS 12", "iPhone Xs Max - iOS 12", "iPhone 11 - iOS 13", "iPhone 11 Pro - iOS 13", "iPhone 11 Pro Max - iOS 13", "iPhone 12 mini - iOS 14", "iPhone 12 - iOS 14", "iPhone 12 Pro - iOS 14", "iPhone 12 Pro Max - iOS 14"]

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "abc")
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath) as! CustomTableViewCell
        // 传递数据
        cell.phone = content[indexPath.row]
        cell.detail = detailContent[indexPath.row]
        return cell
    }
}
