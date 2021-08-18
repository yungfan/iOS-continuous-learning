//
//  ViewController.swift
//  09-configurationUpdateHandler
//
//  Created by 杨帆 on 2021/7/23.
//

import UIKit

class ViewController: UIViewController {
    // 创建UITableView
    let tableView: UITableView = {
        let view = UITableView(frame: UIScreen.main.bounds)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()

    override func viewDidLoad() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // iOS15新增
        cell.configurationUpdateHandler = { cell, state in
            var content = cell.defaultContentConfiguration().updated(for: state)
            var background = cell.backgroundConfiguration?.updated(for: state)
            // 设置内容
            content.text = "text\(indexPath.row)"
            content.secondaryText = "secondaryText\(indexPath.row)"
            content.image = UIImage(systemName: "heart")
            // 根据状态更新
            if state.isHighlighted || state.isSelected {
                content.textProperties.color = .systemRed
                content.secondaryTextProperties.color = .systemRed
                content.imageProperties.tintColor = .systemRed
                content.attributedText = NSAttributedString(string: content.text ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23)])
                background?.backgroundColor = .systemGray2.withAlphaComponent(0.5)
            } else {
                background?.backgroundColor = .clear
            }

            cell.contentConfiguration = content
            cell.backgroundConfiguration = background
        }

        return cell
    }
}
