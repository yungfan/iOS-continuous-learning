//
//  ViewController.swift
//  TableViewScrollToBottom
//
//  Created by 杨帆 on 2021/8/12.
//

import UIKit

class ViewController: UIViewController {
    var content = Array(repeating: 1, count: 1000)

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.self.width, height: UIScreen.main.bounds.self.height - 100), style: .plain)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "abc")
        tableView.separatorStyle = .none
        return tableView
    }()
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "abc")
        cell?.selectionStyle = .none
        cell?.textLabel?.text = "Row \(indexPath.row)"
        return cell!
    }
}
