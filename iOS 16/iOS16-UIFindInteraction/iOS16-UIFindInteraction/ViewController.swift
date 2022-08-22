//
//  ViewController.swift
//  iOS16-UIFindInteraction
//
//  Created by 杨帆 on 2022/8/22.
//

import UIKit

class ViewController: UIViewController {
    lazy var textView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 600))
        textView.text = """
        在 2022 年 6 月的 WWDC 22 上 Apple 推出了 Xcode 14，相比较 Xcode 13，它的功能与性能都有了巨大的提升。
        同样在 WWDC 22 上 Apple 发布了 iOS 16，推出了很多新的内容。
        在掌握了基于 iOS 15 开发的基础上，只要学习以下的新特性就能轻松过渡到 iOS 16。
        """
        textView.center = view.center
        // 打开UIFindInteraction
        textView.isFindInteractionEnabled = true
        // 添加长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        textView.addGestureRecognizer(longPress)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textView)
    }

    // MARK: 长按手势响应事件
    @objc func didLongPress(_ recognizer: UIGestureRecognizer) {
        // 弹出面板
        textView.findInteraction?.presentFindNavigator(showingReplace: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 退出面板
        textView.findInteraction?.dismissFindNavigator()
    }
}
