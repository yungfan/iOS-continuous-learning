import UIKit

enum Section: CaseIterable {
    case main
}

class ViewController: UIViewController {
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "abc")
        tableView.refreshControl = refreshControl
        return tableView
    }()

    lazy var cities: [City] = {
        let cityNames = ["芜湖", "北京", "南京", "西安", "杭州", "苏州", "广州"]
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
    }
}

extension ViewController {
    // 创建数据源
    func createDataSource() {
        // 第一个参数为Section，第二个参数为Model数据类型
        // 闭包是tableView(_:cellForRowAtIndexPath:)方法的替代品
        dataSource = UITableViewDiffableDataSource<Section, City>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, city: City) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "abc", for: indexPath)
            cell.textLabel?.text = city.name
            return cell
        }
        // 显示动画
        dataSource.defaultRowAnimation = .fade
        // 显示数据
        show()
    }

    func show() {
        // 通过数据源获取NSDiffableDataSourceSnapshot
        var snapshot = dataSource.snapshot()
        // 更改NSDiffableDataSourceSnapshot
        snapshot.appendSections([.main])
        snapshot.appendItems(cities, toSection: .main)
        // 应用生效
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc func loadData() {
        var snapshot = dataSource.snapshot()
        // 找到第一个和最后一个
        let firstItem = snapshot.itemIdentifiers(inSection: .main).first
        let lastItem = snapshot.itemIdentifiers(inSection: .main).last
        // 修改并刷新
        if let firstItem = firstItem, let lastItem = lastItem {
            firstItem.name = "厦门"
            lastItem.name = "上海"
            // iOS15新增，替换reloadItems
            snapshot.reconfigureItems([firstItem, lastItem])
            dataSource.apply(snapshot, animatingDifferences: true)
            // 结束刷新
            refreshControl.endRefreshing()
        }
    }
}
