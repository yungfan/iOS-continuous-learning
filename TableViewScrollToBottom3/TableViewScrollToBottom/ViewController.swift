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
        tableView.rowHeight = CGFloat.random(in: 44 ... 50)
        return tableView
    }()

    // 当前可视部分的的最大值
    var currentMaxIndexPathRow: Int? {
        didSet {
            // print("currentMaxIndexPathRow: \(currentMaxIndexPathRow)")
        }
    }

    var halfScreenIndexPath: IndexPath!

    var fullScreenIndexPath: IndexPath! {
        didSet {
            // 在这个范围内一定滚动
            print("[min: \(fullScreenIndexPath.row)，mid：\(halfScreenIndexPath.row)，max： \(self.content.count - 1)]")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self

        // 开启一个周期操作（定时器）
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            self.content.append(100)

            self.update1()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 一开始就滚到TableView的底部
        scrollToBottom(immediate: true)
    }

    // 有新数据加载
    func update1() {
        tableView.reloadData()
        scrollToBottom(immediate: false)
    }

    // 滚到底部
    func scrollToBottom(immediate: Bool, animated: Bool = false) {
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()

            if immediate {
                let indexPath = IndexPath(row: self.content.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            } else {
                // 重新计算区间
                self.calculateRegion()

                guard let currentMaxIndexPathRow = self.currentMaxIndexPathRow else { return }

                // 如果向上滑动了超过当前屏幕的数量的一半就不自动滚到底部
                if self.halfScreenIndexPath.row < currentMaxIndexPathRow {
                    let indexPath = IndexPath(row: self.content.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
            }
        }
    }
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

extension ViewController: UITableViewDelegate {
    // 滚动的时候
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentMaxIndexPathRow = tableView.indexPathsForVisibleRows?.max()?.row

        calculateRegion()
    }
}

extension ViewController {
    func calculateRegion() {
        var visibleCellsHeight: CGFloat = 0

        var condition1 = true
        var condition2 = true

        // 倒序计算cell的高度
        for i in (0 ... content.count - 1).reversed() {
            let indexPath = IndexPath(row: i, section: 0)
            // 每个cell的尺寸
            let rect = tableView.rectForRow(at: indexPath)
            // 累加高度
            visibleCellsHeight += rect.height
            // 当高度超过tableView高度一半
            if visibleCellsHeight > tableView.bounds.size.height * 0.5, condition1 {
                halfScreenIndexPath = indexPath
                condition1 = false
            }
            // 当高度超过tableView高度
            if visibleCellsHeight >= tableView.bounds.size.height, condition2 {
                fullScreenIndexPath = indexPath
                condition2 = false
            }

            // 两个都找到停止遍历
            if !condition1, !condition2 {
                break
            }
        }
    }
}
