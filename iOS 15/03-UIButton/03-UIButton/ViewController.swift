//
//  ViewController.swift
//  03-UIButton
//
//  Created by 杨帆 on 2021/6/10.
//

import UIKit

class ViewController: UIViewController {
    let advancedButton = UIButton(type: .custom)

    var change: Bool = false {
        didSet {
            // 让按钮更新状态
            advancedButton.setNeedsUpdateConfiguration()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        basic()

        advanced()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        change.toggle()
    }
}

extension ViewController {
    // 基本使用
    func basic() {
        // 创建Configuration，有很多种
        var config = UIButton.Configuration.filled()
        // 标题
        config.title = "喜欢"
        // 副标题
        config.subtitle = "love"
        // 图片
        config.image = UIImage(systemName: "heart")
        // 图片间距
        config.imagePadding = 5
        // 文字、图片渲染颜色
        config.baseForegroundColor = .red
        // 背景颜色
        config.background.backgroundColor = .systemBlue
        // 背景圆角
        config.background.cornerRadius = 10
        // 显示进度指示器，有它就不会显示image
        config.showsActivityIndicator = true
        // 内容边距
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        // 设置UIButton.Configuration
        let button = UIButton(type: .custom)
        button.configuration = config
        // 添加
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        view.addSubview(button)
    }

    // 高级使用
    func advanced() {
        // 设置Configuration
        advancedButton.configuration = .bordered()

        // 通过configurationUpdateHandler可以更新按钮的状态
        advancedButton.configurationUpdateHandler = { [weak self] btn in
            if self?.change == true {
                btn.configuration?.title = "登录成功"
                btn.configuration?.showsActivityIndicator = false
                btn.configuration?.imagePadding = 5
                btn.configuration?.image = UIImage(systemName: "checkmark")
            } else {
                btn.configuration?.title = "正在登录"
                btn.configuration?.showsActivityIndicator = true
                btn.configuration?.imagePadding = 5
            }
        }

        // 添加
        advancedButton.frame = CGRect(x: 100, y: 300, width: 200, height: 50)
        view.addSubview(advancedButton)
    }
}
