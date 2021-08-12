//
//  OneViewController.swift
//  OneViewController
//
//  Created by 杨帆 on 2021/8/12.
//

/**
 通过找到最后一个IndexPath，使用scrollToRow实现
 */
import UIKit

class OneViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        // 开启一个周期操作（定时器）
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.content.append(100)

            // self.update1()

            // self.update2()

            self.update3()
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

    func update2() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: content.count - 1, section: 0)], with: .none)
        tableView.endUpdates()
        scrollToBottom(immediate: false, animated: false)
    }

    func update3() {
        tableView.performBatchUpdates {
            tableView.insertRows(at: [IndexPath(row: content.count - 1, section: 0)], with: .none)
        } completion: { _ in
            self.scrollToBottom(immediate: false, animated: false)
        }
    }

    // 滚到底部
    func scrollToBottom(immediate: Bool, animated: Bool) {
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()

            if immediate {
                let indexPath = IndexPath(row: self.content.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            } else {
                let maxIndexPath = self.tableView.indexPathsForVisibleRows?.max()
                guard let maxRow = maxIndexPath?.row else { return }
                // 如果向上滑动了超过一定的数量就不自动滚到底部
                if maxRow > self.content.count - 10 {
                    let indexPath = IndexPath(row: self.content.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
            }
        }
    }
}
