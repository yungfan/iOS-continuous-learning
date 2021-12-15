//
//  ViewController.swift
//  CloudKitDemo
//
//  Created by student on 2021/12/15.
//

import CloudKit
import UIKit

struct Person {
    let id = UUID()
    let recordID: CKRecord.ID
    var name: String
    var address: String
}

class ViewController: UIViewController {
    let cloudKitTools = CloudKitTools()

    var person = [Person]()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        view.addSubview(tableView)

        loadData()
    }

    @objc func loadData() {
        cloudKitTools.query { queryPerson in

            DispatchQueue.main.async {
                self.person = queryPerson
                self.tableView.reloadData()

                if self.tableView.refreshControl!.isRefreshing {
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "abc")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "abc")
        }
        cell?.textLabel?.text = person[indexPath.row].name
        cell?.detailTextLabel?.text = person[indexPath.row].address

        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action1 = UIContextualAction(style: .normal, title: "修改") { _, _, _ in
            let p = self.person[indexPath.row]
            self.person[indexPath.row].name = "李四"
            self.person[indexPath.row].address = "安徽芜湖"
            self.cloudKitTools.update(person: p) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        action1.backgroundColor = .blue

        let action2 = UIContextualAction(style: .normal, title: "删除") { _, _, _ in
            let p = self.person[indexPath.row]
            self.cloudKitTools.delete(person: p) {
                DispatchQueue.main.async {
                    self.person.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            }
        }
        action2.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [action1, action2])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            let recordID = CKRecord.ID(recordName: UUID().uuidString)
            let p = Person(recordID: recordID, name: "张三", address: "江苏南京")
            self.cloudKitTools.add(person: p) {
                DispatchQueue.main.async {
                    self.person.append(p)

                    self.tableView.reloadData()
                }
            }
        }
        action.image = UIImage(systemName: "plus")
        action.backgroundColor = .green

        return UISwipeActionsConfiguration(actions: [action])
    }
}
