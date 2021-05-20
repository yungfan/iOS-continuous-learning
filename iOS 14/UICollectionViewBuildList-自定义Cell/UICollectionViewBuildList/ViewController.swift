//
//  ViewController.swift
//  UICollectionViewBuildList
//
//  Created by 杨帆 on 2020/7/2.
//

import UIKit

class ViewController: UIViewController {
    private lazy var collectionView = makeCollectionView()
    private lazy var dataSource = makeDataSource()

    let cityNames = ["北京", "南京", "西安", "杭州", "苏州"]
    var codeCities: [City] = []
    var nibCities: [City] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        for name in cityNames {
            codeCities.append(City(name: name))
            nibCities.append(City(name: name))
        }

        collectionView.dataSource = dataSource

        view.addSubview(collectionView)

        // 第一次进来刷新
        updateList()
    }
}

extension ViewController {
    // 创建列表式UICollectionView
    func makeCollectionView() -> UICollectionView {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        // 右侧滑动删除
        config.trailingSwipeActionsConfigurationProvider = { indexPath in
            // 找到删除的内容
            guard let city = self.dataSource.itemIdentifier(for: indexPath) else { return nil }

            return UISwipeActionsConfiguration(
                actions: [UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: { [weak self] _, _, completion in
                        self?.deleteCity(city: city, indexPath: indexPath)
                        self?.updateList()

                        completion(true)
                    }
                )]
            )
        }

        // 左侧滑动添加
        config.leadingSwipeActionsConfigurationProvider = {  indexPath in
           
            return UISwipeActionsConfiguration(
                actions: [UIContextualAction(
                    style: .normal,
                    title: "Add",
                    handler: { [weak self] _, _, completion in
                        self?.addCity(city: City(name: self!.cityNames.randomElement()!), indexPath: indexPath)
                        self?.updateList()

                        completion(true)
                    }
                )]
            )
        }

        // 列表布局
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return UICollectionView(frame: view.frame, collectionViewLayout: layout)
    }
}

extension ViewController {
    // 注册Cell
    func makeCellRegistration() -> UICollectionView.CellRegistration<CityCollectionViewCell, City> {
        UICollectionView.CellRegistration { cell, _, city in
            // 自定义Cell显示的内容
            cell.cityLabel.text = city.name

            // AccessoryView
            cell.accessories = [.disclosureIndicator()]
        }
    }

    // Nib
    func makeNibCellRegistration() -> UICollectionView.CellRegistration<CityListCell, City> {
        UICollectionView.CellRegistration(cellNib: UINib(nibName: "CityListCell", bundle: nil)) { cell, indexPath, city in
            // 自定义Cell显示的内容
            cell.cityLabel.text = city.name

            // AccessoryView
            cell.accessories = [.disclosureIndicator()]
        }
    }
}

extension ViewController {
    // 删除数据
    func deleteCity(city: City, indexPath: IndexPath) {
        if indexPath.section == 0 {
            codeCities.remove(at: codeCities.firstIndex(of: city)!)
        } else {
            nibCities.remove(at: nibCities.firstIndex(of: city)!)
        }
    }

    // 增加数据
    func addCity(city: City, indexPath: IndexPath) {
        if indexPath.section == 0 {
            codeCities.append(city)
        } else {
            nibCities.append(city)
        }
    }
}

extension ViewController {
    // 配置数据源
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, City> {
        UICollectionViewDiffableDataSource<Section, City>(
            collectionView: collectionView,
            cellProvider: { view, indexPath, item in
                view.dequeueConfiguredReusableCell(
                    using: self.makeNibCellRegistration(),
                    for: indexPath,
                    item: item
                )
            }
        )
    }
}

enum Section: CaseIterable {
    case code
    case nib
}

extension ViewController {
    func updateList() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, City>()
        // 添加两个分组
        snapshot.appendSections(Section.allCases)
        // 分别往两个分组添加数据
        snapshot.appendItems(codeCities, toSection: .code)
        snapshot.appendItems(nibCities, toSection: .nib)
        dataSource.apply(snapshot)
    }
}
