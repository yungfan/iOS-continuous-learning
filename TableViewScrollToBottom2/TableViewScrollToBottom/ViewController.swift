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

    // 当前可视部分的的最小值
    var currentMinIndexPathRow: Int? {
        didSet {
            print("currentMinIndexPathRow: \(currentMinIndexPathRow)")
        }
    }

    // 当前可视部分的的最大值
    var currentMaxIndexPathRow: Int? {
        didSet {
            print("currentMaxIndexPathRow: \(currentMaxIndexPathRow)")
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

        // 滚到TableView的底部
        scrollToBottom(immediate: true, animated: false)
    }

    func update1() {
        tableView.reloadData()
        scrollToBottom(immediate: false, animated: false)
    }

    // 滚到底部
    func scrollToBottom(immediate: Bool, animated: Bool) {
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()

            if immediate {
                let indexPath = IndexPath(row: self.content.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            } else {
                guard let currentMaxIndexPathRow = self.currentMaxIndexPathRow else { return }
                guard let currentMinIndexPathRow = self.currentMinIndexPathRow else { return }
                // 如果向上滑动了超过当前屏幕的数量的一半就不自动滚到底部
                if currentMaxIndexPathRow > self.content.count - (currentMaxIndexPathRow - currentMinIndexPathRow) / 2 {
                    let indexPath = IndexPath(row: self.content.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }

                floor(3.14)
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
        guard let minRow = tableView.indexPathsForVisibleRows?.min()?.row else { return }

        if 0 != minRow {
            currentMinIndexPathRow = tableView.indexPathsForVisibleRows?.min()?.row
            currentMaxIndexPathRow = tableView.indexPathsForVisibleRows?.max()?.row
        }
    }
}
