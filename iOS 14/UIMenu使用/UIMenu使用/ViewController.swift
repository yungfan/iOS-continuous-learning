//
//  ViewController.swift
//  UIMenu使用
//
//  Created by 杨帆 on 2020/7/1.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.isToolbarHidden = false
        // 菜单绑定到UIBarButtonItem
        let addNewItem = UIBarButtonItem(systemItem: .add, primaryAction: nil, menu: createMenuIOS13())
        toolbarItems = [addNewItem]

        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: nil, menu: createMenuIOS14())
    }

    func createMenuIOS13() -> UIMenu {
        // 第一个菜单
        let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart.fill")) { _ in
            print("favorite")
        }

        // 第二个菜单
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in
            print("share")
        }

        // 第三个菜单
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: [.destructive]) { _ in
            print("delete")
        }

        let menuActions = [favorite, share, delete]

        return UIMenu(
            title: "",
            children: menuActions)
    }

    func createMenuIOS14() -> UIMenu {
        // 应该是是通过网络获取，这里直接从Bundle加载
        let menuItemsForUser = Bundle.main.decode([RemoteItem].self, from: "menu.json")

        // 创建UIDeferredMenuElement
        let dynamicElements = UIDeferredMenuElement { completion in

            // 创建UIAction
            let actions = menuItemsForUser.map { item in
                UIAction(title: item.title, image: UIImage(systemName: item.icon)) { _ in
                    print("\(item.title) tapped")
                }
            }

            // 一定要调用completion处理
            completion(actions)
        }

        return UIMenu(
            title: "",
            children: [dynamicElements])
    }
}

struct RemoteItem: Codable {
    let title: String
    let icon: String
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to find \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let model = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return model
    }
}
