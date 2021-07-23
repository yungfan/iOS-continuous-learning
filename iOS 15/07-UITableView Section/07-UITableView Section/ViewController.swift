//
//  ViewController.swift
//  07-UITableView Section
//
//  Created by 杨帆 on 2021/7/8.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let tableView = UITableView(frame: UIScreen.main.bounds)

        // 新增，给每一个section的header增加一个默认高度
        tableView.sectionHeaderTopPadding = 0

        view.addSubview(tableView)
    }
}
