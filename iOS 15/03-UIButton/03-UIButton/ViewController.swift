//
//  ViewController.swift
//  03-UIButton
//
//  Created by 杨帆 on 2021/6/10.
//

import UIKit

class ViewController: UIViewController {
    lazy var button = UIButton(type: .system)

    var change: Bool? {
        didSet {
            button.setNeedsUpdateConfiguration()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        change = false
        advanced()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        change?.toggle()
    }

    func advanced() {
        button.configuration = .filled()

        button.configurationUpdateHandler = { [weak self] btn in
            if self?.change == true {
                btn.configuration?.title = "已登录"
                btn.configuration?.showsActivityIndicator = false
                btn.configuration?.imagePadding = 5
                btn.configuration?.image = UIImage(systemName: "checkmark")
            } else {
                btn.configuration?.title = "未登录"
                btn.configuration?.showsActivityIndicator = true
                btn.configuration?.imagePadding = 5
            }
        }

        button.center = view.center
        view.addSubview(button)
    }

    func basic() {
        var config = UIButton.Configuration.filled()
        // 文字
        config.title = "喜欢"
        config.subtitle = "love"
        // 图片
        config.image = UIImage(systemName: "heart")
        // 背景
        config.background.backgroundColor = .systemBlue
        // 背景圆角
        config.background.cornerRadius = 10
        // 显示进度指示器，有它不会显示image
        config.showsActivityIndicator = true
        // 图片间距
        config.imagePadding = 5
        // 内容边距
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 20, bottom: 10, trailing: 20
        )

        let btn = UIButton(type: .system)
        // 赋值给UIButton的configuration
        btn.configuration = config

        btn.center = view.center
        view.addSubview(btn)
    }
}
