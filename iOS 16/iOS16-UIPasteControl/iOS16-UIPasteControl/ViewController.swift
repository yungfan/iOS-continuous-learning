//
//  ViewController.swift
//  iOS16-UIPasteControl
//
//  Created by 杨帆 on 2022/8/21.
//

import UIKit

class ViewController: UIViewController {
    lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20,
                                                  y: 200,
                                                  width: UIScreen.main.bounds.width - 40,
                                                  height: 40))
        textField.borderStyle = .roundedRect
        return textField
    }()

    // UIPasteControl
    lazy var pasteControl: UIPasteControl = {
        // 创建配置
        let config = UIPasteControl.Configuration()
        // 背景色
        config.baseBackgroundColor = .orange
        // 图标与文字颜色
        config.baseForegroundColor = .green
        // 形状
        config.cornerStyle = .capsule
        // 显示模式
        config.displayMode = .iconAndLabel
        // 创建UIPasteControl
        let pasteControl = UIPasteControl(configuration: config)
        // 设置target，获取剪切板内容后粘贴的位置
        pasteControl.target = textField
        pasteControl.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        pasteControl.center = view.center
        return pasteControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textField)
        view.addSubview(pasteControl)
    }
}

