import UIKit

enum Section: CaseIterable {
    case main
}

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "abc")
        tableView.delegate = self
        return tableView
    }()

    lazy var cities: [City] = {
        let cityNames = ["北京", "南京", "西安", "杭州", "南通", "南阳", "苏州", "泰山", "黄山", "广州", "芜湖", "巢湖", "锦州", "湖州", "北海", "海口", "安庆", "安顺"]
        var cities = [City]()
        for name in cityNames {
            cities.append(City(name: name))
        }
        return cities
    }()

    // 数据源
    var dataSource: UITableViewDiffableDataSource<Section, City>!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        createDataSource()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delete()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.add()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.update()
        }
    }
}

extension ViewController {
    // 创建数据源
    func createDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, City>(tableView: tableView) { // 该闭包是tableView(_:cellForRowAtIndexPath:)方法的替代品
            (tableView: UITableView, indexPath: IndexPath, city: City) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath)
            cell.textLabel?.text = city.name
            return cell
        }
        // 显示动画
        dataSource.defaultRowAnimation = .fade
        show()
    }

    func show() {
        // 获取NSDiffableDataSourceSnapshot
        var snapshot = dataSource.snapshot()
        // 增加数据
        snapshot.appendSections([.main])
        snapshot.appendItems(cities, toSection: .main)
        // 更新
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController {
    // 增加
    func add() {
        // 获取NSDiffableDataSourceSnapshot
        var snapshot = dataSource.snapshot()
        let city = [City(name: "AA")]
        // 更改NSDiffableDataSourceSnapshot
        snapshot.appendItems(city)
        // 更新
        dataSource.apply(snapshot)
    }

    // 删除
    func delete() {
        var snapshot = dataSource.snapshot()
        if let item = snapshot.itemIdentifiers(inSection: .main).first {
            snapshot.deleteItems([item])
            dataSource.apply(snapshot)
        }
    }

    // 修改
    func update() {
        var snapshot = dataSource.snapshot()
        if let item = snapshot.itemIdentifiers(inSection: .main).first {
            let city = [City(name: "AA")]
            // 插入新的并删除旧的
            snapshot.insertItems(city, beforeItem: item)
            snapshot.deleteItems([item])
            dataSource.apply(snapshot)
        }
    }

    // 重新加载
    func reload() {
        var snapshot = dataSource.snapshot()
        let items = snapshot.itemIdentifiers(inSection: .main)
        var item = items.last
        item?.name = "AA"
        snapshot.reloadItems(items)
        dataSource.apply(snapshot)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = dataSource.itemIdentifier(for: indexPath) {
            print("选择了\(city.name)")
        }
    }
}
