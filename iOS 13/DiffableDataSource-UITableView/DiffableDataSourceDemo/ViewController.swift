import UIKit

enum Section: CaseIterable {
    case main
}

class ViewController: UIViewController {
    let cityNames = ["北京", "南京", "西安", "杭州", "南通", "南阳", "苏州", "泰山", "黄山", "广州", "芜湖", "巢湖", "锦州", "湖州", "北海", "海口", "安庆", "安顺"]

    @IBOutlet var tableView: UITableView!

    var cities: [City] = [City]()

    var dataSource: UITableViewDiffableDataSource<Section, City>!

    override func viewDidLoad() {
        super.viewDidLoad()

        for name in cityNames {
            cities.append(City(name: name))
        }

        dataSource = UITableViewDiffableDataSource
        <Section, City>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath,
             city: City) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = city.name
            return cell
        }

        dataSource.defaultRowAnimation = .fade
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 改
        // cities = [City(name: "AA")]

        // 增
        // cities.append(City(name: "AA"))

        // 删
        // cities.remove(at: 0)

        cities.remove(at: 0)
        cities.insert(City(name: "BB"), at: 0)

        // 直接获取不行
        // var snapshot = dataSource.snapshot()
        // 必须创建一个新的
        var snapshot = NSDiffableDataSourceSnapshot<Section, City>()

        snapshot.appendSections([.main])

        snapshot.appendItems(cities, toSection: .main)

        dataSource.apply(snapshot)
    }

    // 刚开始需要显示所有数据
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        performSearch(searchQuery: nil)
    }

    func performSearch(searchQuery: String?) {
        let filteredCities: [City]

        if let searchQuery = searchQuery, !searchQuery.isEmpty {
            filteredCities = cities.filter { $0.contains(query: searchQuery) }
        } else {
            filteredCities = cities
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, City>()

        snapshot.appendSections([.main])

        snapshot.appendItems(filteredCities, toSection: .main)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(searchQuery: searchText)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = dataSource.itemIdentifier(for: indexPath) {
            print("选择了\(city.name)")
        }
    }
}
