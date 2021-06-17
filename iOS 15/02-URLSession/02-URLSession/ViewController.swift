//
//  ViewController.swift
//  02-URLSession
//
//  Created by 杨帆 on 2021/6/10.
//

import UIKit

class ViewController: UIViewController {
    let newLoader = NewsLoader()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadNews()
    }

    func loadNews() {
        // 调用时也必须包含在async块内
        async {
            do {
                let news = try await newLoader.loadNews(from: URL(string: "http://rap2api.taobao.org/app/mock/data/1772974")!)

                for n in news {
                    print(n.title)
                }
            } catch {
                print(error)
            }
        }
    }
}

struct News: Codable {
    var author, title, department, date, url: String
    var important: Bool
}

struct NewsModel: Codable {
    let result: [News]
}

struct NewsLoader {
    var session = URLSession.shared

    func loadNews(from url: URL) async throws -> [News] {
        // 新的语法加载数据
        let (data, response) = try await session.data(from: url)
        print(response)
        let decoder = JSONDecoder()
        return try decoder.decode(NewsModel.self, from: data).result
    }
}
