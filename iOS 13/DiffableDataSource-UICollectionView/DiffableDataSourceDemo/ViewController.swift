//
//  ViewController.swift
//  DiffableDataSourceDemo
//
//  Created by 杨帆 on 2020/5/29.
//  Copyright © 2020 杨帆. All rights reserved.
//

import UIKit

enum Section: CaseIterable {
    case main
}

class ViewController: UIViewController {
    let cityNames = ["北京", "南京", "西安", "杭州", "苏州", "南通", "南阳", "苏州", "泰山", "黄山", "广州", "芜湖", "巢湖", "锦州", "湖州", "北海", "海口", "安庆", "安顺"]

    @IBOutlet var collectionView: UICollectionView!

    var cities: [City] = []

    var dataSource: UICollectionViewDiffableDataSource<Section, City>!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = generateLayout()

        for name in cityNames {
            cities.append(City(name: name))
        }

        dataSource = UICollectionViewDiffableDataSource<Section, City>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, city: City) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CityCollectionViewCell
            cell?.cityLb.text = city.name
            return cell
        }

        // 注册SupplementaryView
        collectionView.register(BadgeView.self, forSupplementaryViewOfKind: "badge", withReuseIdentifier: BadgeView.reuseIdentifier)

        // 设置SupplementaryView
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BadgeView.reuseIdentifier, for: indexPath) as? BadgeView {
                return badgeView
            } else {
                fatalError("Cannot create Supplementary")
            }
        }
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

extension ViewController {
    func generateLayout() -> UICollectionViewCompositionalLayout {
        // 1 构造Item的NSCollectionLayoutSize
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))

        // 2 构造NSCollectionLayoutItem

        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.5, y: -0.4))

        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(16), heightDimension: .absolute(16))

        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: "badge", containerAnchor: badgeAnchor)

        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])

        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        // 3 构造Group的NSCollectionLayoutSize
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.1))

        // 4 构造NSCollectionLayoutGroup
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        // 5 构造NSCollectionLayoutSection
        let section = NSCollectionLayoutSection(group: group)

        // 6 构造UICollectionViewCompositionalLayout
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let city = dataSource.itemIdentifier(for: indexPath) {
            print("选择了\(city.name)")
        }
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        // 第一个
        let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart.fill")) { _ in
            print("favorite")
        }

        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in
            print("share")
        }

        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { _ in
            print("delete")
            var snapshot = self.dataSource.snapshot()
            if let item = snapshot.itemIdentifiers(inSection: .main).first {
                snapshot.deleteItems([item])
                self.dataSource.apply(snapshot)
            }
        }

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "Actions", children: [favorite, share, delete])
        }
    }
}
